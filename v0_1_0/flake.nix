{
  description = ''Single-producer, single-consumer, lock-free queue implementations for Nim.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-lockfreequeues-v0_1_0.flake = false;
  inputs.src-lockfreequeues-v0_1_0.ref   = "refs/tags/v0.1.0";
  inputs.src-lockfreequeues-v0_1_0.owner = "elijahr";
  inputs.src-lockfreequeues-v0_1_0.repo  = "lockfreequeues";
  inputs.src-lockfreequeues-v0_1_0.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-lockfreequeues-v0_1_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-lockfreequeues-v0_1_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}