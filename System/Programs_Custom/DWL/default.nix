{ lib
, fcft
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
  name              = "DWL_Custom";
 
  passthru.providedSessions = [
    "dwl"
  ];

  src = /home/luca/Repositories/DWL;

  # src = fetchFromGitea {
  #   repo   = "DWL";
  #   owner  = "BroomBear";
  #   domain = "codeberg.org";
  #   rev    = "7b9f914164f5eb883b02df445debccdfaa20eb80";
  #   hash   = "sha256-04UL86N9YlGbFBqwvkm6AXZeoBwrMh+XRgc4RhJ8pYc=";
  # };

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
