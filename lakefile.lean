import Lake
open Lake DSL

package «IEC» where

require RCC from git "https://github.com/residua-labs/RCC" @ "0f7f5f39ff36f8f21c13e649c35127c235ab3df6"

@[default_target]
lean_lib «IEC» where
  roots := #[`IEC]
  globs := #[.andSubmodules `IEC, .submodules `Conflux]

@[default_target]
lean_lib «IECTests» where
  roots := #[`IECTests]
  globs := #[.andSubmodules `IECTests]
