#!/bin/bash

BASE_DIR="$HOME/Pictures"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

echo "Creating picture organization system in: $BASE_DIR"

# unsorted - for initial sorting
mkdir -p unsorted

# random - sorted... but random/absurd
mkdir -p random

# web - found there, for use there (reactions, memes, responses)
mkdir -p web/{negative,positive,other}
mkdir -p web/other/{confused,surprised,thinking} # more?

# personal - for personal content
mkdir -p personal/photos

# thematic - organized by subject/topic
mkdir -p topics/{geography,history,hobbies,linguistics,literature,local,military,osint,politics,science,sports,technology}
mkdir -p topics/sports/{baseball,football,hockey,soccer}

# gallery - visual/artistic content
mkdir -p gallery/{art,photography}
# wallpaper will be symlinked there

# utility - functional content
mkdir -p utility/{icons,logos,templates,editing,reference,screenshots}

# comics - standalone for full comic strips
mkdir -p comics

# foreign - foreign language content
mkdir -p foreign/{ar,de,pt,zh}

echo "All directory structures created!"
