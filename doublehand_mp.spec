# -*- mode: python ; coding: utf-8 -*-

import os


# Release builds must use a Developer ID identity supplied locally.
# The identity is intentionally not stored in the repository.
codesign_identity = os.environ.get('GESTURECAP_CODESIGN_IDENTITY')

if not codesign_identity:
    raise RuntimeError(
        'GESTURECAP_CODESIGN_IDENTITY must be set for a signed release build.'
    )


a = Analysis(
    ['doublehand_mp.py'],
    pathex=[],
    binaries=[],
    datas=[('models', 'models')],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='doublehand_mp',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=codesign_identity,
    entitlements_file=None,
)

coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='doublehand_mp',
)