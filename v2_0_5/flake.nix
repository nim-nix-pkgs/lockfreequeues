{
  description = ''Lock-free queue implementations for Nim.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-lockfreequeues-v2_0_5.flake = false;
  inputs.src-lockfreequeues-v2_0_5.owner = "elijahr";
  inputs.src-lockfreequeues-v2_0_5.ref   = "v2_0_5";
  inputs.src-lockfreequeues-v2_0_5.repo  = "lockfreequeues";
  inputs.src-lockfreequeues-v2_0_5.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-lockfreequeues-v2_0_5"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-lockfreequeues-v2_0_5";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}