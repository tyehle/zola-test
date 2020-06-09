#!/usr/bin/env just --justfil

install-zola target="$HOME/.cargo/bin/" platform="x86_64-unknown-linux-gnu":
    #!/usr/bin/env bash
    if command -v zola > /dev/null 2>&1; then
        echo "target='{{target}}' platform='{{platform}}'"
        echo "zola is already installed"
    else
        curl --silent https://api.github.com/repos/getzola/zola/releases/latest | \
            jq -r '.assets[] | select(.name | contains("{{platform}}")).browser_download_url' | \
            xargs curl --location --output - | \
            tar --directory="{{target}}" -xzf -
    fi

serve host="localhost":
    zola serve --drafts --interface={{host}} --port=4000

build:
    zola build
