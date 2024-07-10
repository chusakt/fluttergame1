# Define the repository name
$REPO_NAME = "https://github.com/chusakt/fgame"

# Build the Flutter web app
flutter build web

# Navigate to the build/web directory
Set-Location -Path .\build\web

# Update the base href in index.html
(Get-Content -Path index.html) -replace '<base href="/"', "<base href='/$REPO_NAME/'" | Set-Content -Path index.html

# Navigate back to the root directory
Set-Location -Path ../..

# Initialize a new orphan branch 'gh-pages'
git checkout --orphan gh-pages

# Remove all files from the new branch
git rm -rf .

# Copy the build output to the new branch
Copy-Item -Path .\build\web\* -Destination . -Recurse

# Add and commit all files
git add .
git commit -m "Deploying web app to GitHub Pages"

# Push the changes to the remote 'gh-pages' branch
git push origin gh-pages --force

# Switch back to the main branch
git checkout main
