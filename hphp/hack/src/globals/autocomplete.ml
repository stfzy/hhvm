(**
 * Copyright (c) 2014, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "hack" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 *)
open Utils

type autocomplete_result = {
    pos         : Pos.t;
    ty          : string;
    name        : string;
    expected_ty : bool;
  }

(*****************************************************************************)
(* Auto-complete mode *)
(*****************************************************************************)

let auto_complete = ref false
(* The position we're autocompleting at. This is used so when we reach this
 * position in typing, we can recognize it and store types. Set in naming. *)
let (auto_complete_pos: Pos.t option ref) = ref None
(* A map of variable names to ident at the autocomplete point. This is
 * set in naming. When we reach this point in typing, variable names are
 * not available, but we can use this map to relate names to types *)
let auto_complete_vars = ref (SMap.empty: Ident.t SMap.t)

(*****************************************************************************)
(* Argument info mode *)
(*****************************************************************************)
let (argument_info_target: (int * int) option ref) = ref None
let (argument_info_expected: ((string option * string) list) option ref) = ref None
let (argument_info_position: int option ref) = ref None


(*****************************************************************************)
(* Returns true if this is the identifier we want to auto-complete *)
(*****************************************************************************)

type autocomplete_type =
| Acid
| Acnew
| Actype
| Acclass_get
| Acvar

let make_result name p ty expected_ty = {
    pos         = p;
    ty          = ty;
    name        = name;
    expected_ty = expected_ty;
  }

let (argument_global_type: autocomplete_type option ref) = ref None
let auto_complete_for_global = ref ""
