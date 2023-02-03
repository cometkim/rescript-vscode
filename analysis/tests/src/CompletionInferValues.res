let getBool = () => true
let getInt = () => 123

type someRecord = {name: string, age: int}

let someFnWithCallback = (cb: (~num: int, ~someRecord: someRecord, ~isOn: bool) => unit) => {
  let _ = cb
}

let reactEventFn = (cb: ReactEvent.Mouse.t => unit) => {
  let _ = cb
}

@val external getSomeRecord: unit => someRecord = "getSomeRecord"

// let x = 123; let aliased = x; aliased->f
//                                         ^com

// let x = getSomeRecord(); x.
//                            ^com

// let x = getSomeRecord(); let aliased = x; aliased.
//                                                   ^com

// someFnWithCallback((~someRecord, ~num, ~isOn) => someRecord.)
//                                                             ^com

// Broken because not using the first argument (argument context seems to pile on when they should be plucked off and new one added)
// let aliasedFn = someFnWithCallback; aliasedFn((~num, ~someRecord, ~isOn) => someRecord.)
//                                                                                        ^com

// reactEventFn(event => { event->pr });
//                                  ^com

module Div = {
  @react.component
  let make = (~onMouseEnter: option<JsxEvent.Mouse.t => unit>=?) => {
    let _ = onMouseEnter
    React.null
  }
}

// let _ = <div onMouseEnter={event => { event->pr }} />
//                                                ^com

// let _ = <Div onMouseEnter={event => { event->pr }} />
//                                                ^com

// let _ = <div onMouseEnter={event => { let btn = event->JsxEvent.Mouse.button; btn->t }} />
//                                                                                     ^com

// let _ = <div onMouseEnter={event => { let btn = event->JsxEvent.Mouse.button->Belt.Int.toString; btn->spl }} />
//                                                                                                          ^com

// let _ = <div onMouseEnter={event => { let btn = event->JsxEvent.Mouse.button->Belt.Int.toString->Js.String2.split("/"); btn->ma }} />
//                                                                                                                                ^com

// let x: someRecord = {name: "Hello", age: 123}; x.
//                                                  ^com

type someVariant = One | Two | Three(int, string)
type someNestedRecord = {someRecord: someRecord}

type someRecordWithNestedStuff = {
  things: string,
  someInt: int,
  srecord: someRecord,
  nested: someNestedRecord,
  someStuff: bool,
}

type otherNestedRecord = {someRecord: someRecord, someTuple: (someVariant, int)}

// Destructure record
// let x: someRecordWithNestedStuff = Obj.magic(); let {srecord} = x; srecord.
//                                                                            ^com

// Follow aliased
// let x: someRecordWithNestedStuff = Obj.magic(); let {nested: aliased} = x; aliased.
//                                                                                    ^com

// Follow nested record
// let x: someRecordWithNestedStuff = Obj.magic(); let {srecord, nested: {someRecord}} = x; someRecord.
//                                                                                                     ^com

// Destructure string
// let x: someRecordWithNestedStuff = Obj.magic(); let {things} = x; things->slic
//                                                                               ^com

// Destructure int
// let x: someRecordWithNestedStuff = Obj.magic(); let {someInt} = x; someInt->toS
//                                                                                ^com

// Follow tuples
// let x: otherNestedRecord = Obj.magic(); let {someTuple} = x; let (_, someInt) = someTuple; someInt->toS
//                                                                                                        ^com

// Same as above, but follow in switch case
// let x: otherNestedRecord; switch x { | {someTuple} => let (_, someInt) = someTuple; someInt->toS }
//                                                                                                 ^com

let fnWithRecordCallback = (cb: someRecord => unit) => {
  let _ = cb
}

// Complete pattern of function parameter
// fnWithRecordCallback(({}) => {()})
//                        ^com
