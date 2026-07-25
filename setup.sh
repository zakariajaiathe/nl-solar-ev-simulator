#!/usr/bin/env bash
# One-shot GitHub Pages setup for the NL solar & EV simulator.
#
# Prerequisites (one time):
#   1. Install GitHub CLI:  https://cli.github.com
#   2. Authenticate:        gh auth login
#
# Then, from inside this folder:
#   bash setup.sh
#
set -euo pipefail

REPO="nl-solar-ev-simulator"
DESC="Interactive simulator for Dutch home solar + EV charging economics, before and after the 2027 salderingsregeling phase-out."

# --- checks -----------------------------------------------------------------
command -v git >/dev/null || { echo "git not found. Install git first."; exit 1; }
command -v gh  >/dev/null || { echo "GitHub CLI not found. Install from https://cli.github.com then run: gh auth login"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Not authenticated. Run: gh auth login"; exit 1; }
[ -f index.html ] || { echo "index.html not found. Run this from the unzipped repo folder."; exit 1; }

USER=$(gh api user --jq .login)
echo "Authenticated as: $USER"

# --- personalise the README link -------------------------------------------
if grep -q "YOUR-USERNAME" README.md 2>/dev/null; then
  sed -i.bak "s|YOUR-USERNAME|$USER|g" README.md && rm -f README.md.bak
  echo "README live link set to https://$USER.github.io/$REPO/"
fi

# --- init and commit --------------------------------------------------------
if [ ! -d .git ]; then
  git init -q
  git branch -M main
fi
git add -A
git diff --cached --quiet || git commit -q -m "Add NL solar & EV charging economics simulator"
echo "Committed."

# --- create the repo (public) ----------------------------------------------
if gh repo view "$USER/$REPO" >/dev/null 2>&1; then
  echo "Repo $USER/$REPO already exists — pushing to it."
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$USER/$REPO.git"
  git push -u origin main
else
  gh repo create "$REPO" --public --source=. --remote=origin --description "$DESC" --push
  echo "Repo created and pushed."
fi

# --- enable GitHub Pages ----------------------------------------------------
echo "Enabling GitHub Pages..."
gh api -X POST "repos/$USER/$REPO/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || gh api -X PUT "repos/$USER/$REPO/pages" \
       -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || echo "  (Pages may already be on, or needs enabling manually: Settings > Pages > main / root)"

# --- add topics for discoverability ----------------------------------------
gh api -X PUT "repos/$USER/$REPO/topics" \
  -f "names[]=solar" -f "names[]=ev-charging" -f "names[]=netherlands" \
  -f "names[]=energy" -f "names[]=simulator" -f "names[]=saldering" >/dev/null 2>&1 || true

echo
echo "Done."
echo "  Repo: https://github.com/$USER/$REPO"
echo "  Live: https://$USER.github.io/$REPO/   (first build takes ~1 minute)"
