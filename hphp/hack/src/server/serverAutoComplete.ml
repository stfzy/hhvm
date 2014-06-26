(**
 * Copyright (c) 2014, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "hack" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 *)


(*****************************************************************************)
(* Code for auto-completion *)
(*****************************************************************************)
open Utils

let auto_complete env content oc =
  AutocompleteService.attach_hooks();
  let funs, classes = ServerIdeUtils.declare content in
  let nenv = env.ServerEnv.nenv in
  let dummy_pos = Pos.none, Ident.foo in
  let ifuns = 
    SSet.fold begin fun x acc -> SMap.add x dummy_pos acc
    end funs nenv.Naming.ifuns
  in
  let iclasses = 
    SSet.fold begin fun x acc -> 
      SMap.add x dummy_pos acc
    end classes nenv.Naming.iclasses
  in
  let nenv = 
    { nenv with Naming.ifuns = ifuns; Naming.iclasses = iclasses } in
  ServerIdeUtils.fix_file_and_def content;
  let fun_names = SMap.keys nenv.Naming.ifuns in
  let class_names = SMap.keys nenv.Naming.ifuns in
  let result =
    List.map
      (fun res ->
        let name = res.Autocomplete.name in
        let pos = res.Autocomplete.pos in
        let ty = res.Autocomplete.ty in
        let pos_string = Pos.string pos in
        let name = name^" "^ty in
        (name, pos_string))
      (AutocompleteService.get_results fun_names class_names)
  in
  ServerIdeUtils.revive funs classes;
  Printf.printf "Auto-complete\n"; flush stdout;
  List.iter begin fun (k, _) ->
    Printf.fprintf oc "%s\n" k; flush oc;
  end result;
  AutocompleteService.detach_hooks();
  ()
