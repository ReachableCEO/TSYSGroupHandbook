# Build the book
mdbook build 

#Copy assets into place
rsync -av book/* ../publish-TSGHandbook

# Commit the generated assets
cd ../publish-TSGHandbook
git add -A 
git commit -m 'deploy new website version'

# Push the assets to the github page target.
git push page master

cd ..