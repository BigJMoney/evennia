# 
# deploy to github 
# 
# This copies the recently built files from build/html into the github-gh branch. Note that 
# it's important that build/ must not be committed to git!
# 

if [ -n "$(git status --untracked-files=no --porcelain)" ]; then
  echo "There are uncommitted changes. Make sure to commit everything in your current branch first."
  exit 1
fi

# get the deployment branch
git checkout gh-pages
# at this point we should be inside the docs/ folder of the gh-pages branch,
# with the build/ directory available since this is not in git

# remove all but the build dir
ls -Q | grep -v build | xargs rm -Rf

cp -Rf build/html/versions/* .
# docs/build is in .gitignore so will not be included
git add .

# TODO automate this? 
ln -s 1.0-dev latest

git add docs/*
git commit -a -m "Updated HTML docs"

mv build docs/

echo "Skipping deployment"
# git push origin gh-pages

# get back to previous branch 
git checkout -

echo "Deployed to https://evennia.github.io/evennia-docs."
