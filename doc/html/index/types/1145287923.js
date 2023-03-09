// This file was generated by purescript-docs-search
window.DocsSearchTypeIndex["1145287923"] = [{"values":[{"sourceSpan":{"start":[372,1],"name":"src/Internal/Contract/Monad.purs","end":[377,4]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"ContractTimeParams","moduleName":"Ctl.Internal.Contract.Monad","info":{"values":[{"type":{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Record"]},{"tag":"RCons","contents":["awaitTxConfirmed",{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Record"]},{"tag":"RCons","contents":["delay",{"tag":"TypeConstructor","contents":[["Data","Time","Duration"],"Milliseconds"]},{"tag":"RCons","contents":["timeout",{"tag":"TypeConstructor","contents":[["Data","Time","Duration"],"Seconds"]},{"tag":"REmpty","contents":{}}]}]}]},{"tag":"RCons","contents":["waitUntilSlot",{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Record"]},{"tag":"RCons","contents":["delay",{"tag":"TypeConstructor","contents":[["Data","Time","Duration"],"Milliseconds"]},{"tag":"REmpty","contents":{}}]}]},{"tag":"RCons","contents":["syncWallet",{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Record"]},{"tag":"RCons","contents":["delay",{"tag":"TypeConstructor","contents":[["Data","Time","Duration"],"Milliseconds"]},{"tag":"RCons","contents":["timeout",{"tag":"TypeConstructor","contents":[["Data","Time","Duration"],"Seconds"]},{"tag":"REmpty","contents":{}}]}]}]},{"tag":"RCons","contents":["syncBackend",{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Record"]},{"tag":"RCons","contents":["delay",{"tag":"TypeConstructor","contents":[["Data","Time","Duration"],"Milliseconds"]},{"tag":"RCons","contents":["timeout",{"tag":"TypeConstructor","contents":[["Data","Time","Duration"],"Seconds"]},{"tag":"REmpty","contents":{}}]}]}]},{"tag":"REmpty","contents":{}}]}]}]}]}]},"arguments":[]}],"tag":"TypeSynonymResult"},"hashAnchor":"t","comments":"Delays and timeouts for internal query functions.\n\n- `awaitTxConfirmed.delay` - how frequently should we query for Tx in\n`Contract.Transaction.awaitTxConfirmed`\n\n- For info on `syncBackend` and syncWallet` see `doc/query-layers.md`\n"}],"tag":"SearchResult"}]