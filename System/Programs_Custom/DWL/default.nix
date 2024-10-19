{ fcft
, libdrm
, libX11
, libxcb
, pixman
, stdenv
, wayland
, wlroots
, libinput
, xwayland
, xcbutilwm
, pkg-config
, libxkbcommon
, fetchFromGitea
, wayland-scanner
, installShellFiles
, wayland-protocols
}:

stdenv.mkDerivation {
  strictDeps        = true;
  __structuredAttrs = true;
  name              = "DWL";

  src = fetchFromGitea {
    repo   = "DWL";
    owner  = "BroomBear";
    domain = "codeberg.org";
    rev    = "af9e8df16e6ee822ef1de8784a7e66edd60b148f";
    hash   = "sha256-wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww=";
  };

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
    installShellFiles
  ];

  buildInputs = [
   fcft
   libdrm
   libX11
   libxcb
   libinput
   libxkbcommon
   pixman
   wayland
   wlroots
   wayland-protocols
   xcbutilwm
   xwayland
 ];

  outputs = [
    "out"
    "man"
  ];

  makeFlags = [
    "PREFIX=$(out)"
    "MANDIR=$(man)/share/man"
    ''XWAYLAND="-DXWAYLAND"''
    ''XLIBS="xcb xcb-icccm"''
    "WAYLAND_SCANNER=wayland-scanner"
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
  ];
}
