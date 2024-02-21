from sys import argv
import os
import fontforge

d = os.path.dirname(os.path.realpath(__file__))
if len(argv) > 3:
    f = fontforge.open(os.path.join(d, f"../out/{argv[1]}.sfd"))
    f.importBitmaps(os.path.join(d, f"../out/{argv[1]}.bdf"))
else:
    f = fontforge.open(os.path.join(d, f"../out/{argv[1]}.{argv[2]}"))
f.fontname = argv[1]
f.fullname = argv[1]
f.encoding = "UnicodeFull"
f.os2_panose = (0, 0, 0, 9, 0, 0, 0, 0, 0, 0)
f.save(os.path.join(d, f"../out/{argv[1]}.sfd"))
f.generate(os.path.join(d, f"../out/{argv[1]}.{argv[2]}"))
