module Helpers
  ( (</>)
  , (<<>>)
  , (<\>)
  , appendFirstMaybe
  , appendLastMaybe
  , appendMap
  , appendRightHashMap
  , fromJustEff
  , fromRightEff
  , liftEither
  , liftM
  , liftMWith
  , filterMapWithKeyM
  , maybeArrayMerge
  ) where

import Prelude

import Control.Monad.Error.Class (class MonadError, throwError)
import Data.Array (union)
import Data.Either (Either(Right), either)
import Data.Function (on)
import Data.HashMap (HashMap)
import Data.HashMap (unionWith) as HashMap
import Data.Hashable (class Hashable)
import Data.List.Lazy as LL
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe(Just, Nothing), maybe)
import Data.Maybe.First (First(First))
import Data.Maybe.Last (Last(Last))
import Data.Tuple (uncurry)
import Effect (Effect)
import Effect.Exception (throw)

-- | Throws provided error on `Nothing`
fromJustEff :: forall (a :: Type). String -> Maybe a -> Effect a
fromJustEff e = case _ of
  Nothing -> throw e
  Just x -> pure x

liftEither
  :: forall (a :: Type) (e :: Type) (m :: Type -> Type)
   . MonadError e m
  => Either e a
  -> m a
liftEither = either throwError pure

fromRightEff :: forall (a :: Type) (e :: Type). Show e => Either e a -> Effect a
fromRightEff = either (throw <<< show) pure

-- | Given an error and a `Maybe` value, lift the context via `liftEither`.
liftM
  :: forall (e :: Type) (m :: Type -> Type) (a :: Type)
   . MonadError e m
  => e
  -> Maybe a
  -> m a
liftM err = liftEither <<< maybe (throwError err) Right

-- | Given an error and a `Maybe` value, lift the context via `liftEither` with
-- | a handler on `Right`.
liftMWith
  :: forall (e :: Type) (m :: Type -> Type) (a :: Type) (b :: Type)
   . MonadError e m
  => e
  -> (a -> b)
  -> Maybe a
  -> m b
liftMWith err f = liftEither <<< maybe (throwError err) (Right <<< f)

-- | Combine two `Maybe`s taking the `First` `Maybe`
appendFirstMaybe :: forall (a :: Type). Maybe a -> Maybe a -> Maybe a
appendFirstMaybe m m' = on (<>) First m m' # \(First m'') -> m''

infixr 5 appendFirstMaybe as <\>

-- | Combine two `Maybe`s taking the `Last` `Maybe`
appendLastMaybe :: forall (a :: Type). Maybe a -> Maybe a -> Maybe a
appendLastMaybe m m' = on (<>) Last m m' # \(Last m'') -> m''

infixr 5 appendLastMaybe as </>

-- | Combine two `Maybe` `Array`'s where `Nothing` and the empty `Array` both
-- | act as an identity
maybeArrayMerge
  :: forall (a :: Type)
   . Eq a
  => Maybe (Array a)
  -> Maybe (Array a)
  -> Maybe (Array a)
maybeArrayMerge Nothing y = y
maybeArrayMerge x Nothing = x
maybeArrayMerge (Just x) (Just y) = Just $ union x y

infixr 5 maybeArrayMerge as <<>>

-- | Provide an append for Maps where the value has as `Semigroup` instance
appendMap
  :: forall (k :: Type) (v :: Type)
   . Ord k
  => Semigroup v
  => Map k v
  -> Map k v
  -> Map k v
appendMap = Map.unionWith (<>)

-- | Provide an append for `HashMap`s where with right bias
appendRightHashMap
  :: forall (k :: Type) (v :: Type)
   . Hashable k
  => HashMap k v
  -> HashMap k v
  -> HashMap k v
appendRightHashMap = HashMap.unionWith (flip const)

filterMapWithKeyM
  :: forall (m :: Type -> Type) (k :: Type) (v :: Type)
   . Ord k
  => Monad m
  => (k -> v -> m Boolean)
  -> Map k v
  -> m (Map k v)
filterMapWithKeyM p = map Map.fromFoldable <<< LL.filterM (uncurry p) <<< Map.toUnfoldable
