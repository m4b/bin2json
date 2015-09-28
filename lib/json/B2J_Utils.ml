let get_mode architecture =
  if (architecture = "i386"
      || architecture = "I386"
      || architecture = "arm"
      || architecture = "ARM"
      || architecture = "arm32"
      || architecture = "ARM32"
      || architecture = "AARCH32"
      || architecture = "aarch32")
  then
    32
  else if (
    architecture = "x86-64"
    || architecture = "X86-64"
    || architecture = "X86_64"
    || architecture = "x86_64"
    || architecture = "arm64"
    || architecture = "ARM64"
    || architecture = "AARCH64"
    || architecture = "aarch64")
  then
    64
  else 0

let get_arch architecture =
  if (architecture = "i386" || architecture = "I386"
      || architecture = "x86"
      || architecture = "X86"
      || architecture = "x86-64"
      || architecture = "X86-64"
      || architecture = "X86_64"
      || architecture = "x86_64")
  then "x86"
  else if (architecture = "ARM"
           || architecture = "arm"
           || architecture = "arm64"
           || architecture = "ARM64"
           || architecture = "AARCH64"
           || architecture = "aarch64")
  then "arm"
  else "unknown"
