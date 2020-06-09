#!/usr/bin/env just --justfil

serve host="localhost":
    zola serve --drafts --interface={{host}} --port=4000
