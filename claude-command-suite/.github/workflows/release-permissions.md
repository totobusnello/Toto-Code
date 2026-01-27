# Release Workflow Permissions Setup

✅ **RELEASE_TOKEN has been configured for this repository**

The release workflow is now using a Personal Access Token (RELEASE_TOKEN) which allows it to push changes back to the repository, even with branch protection rules enabled.

## Current Configuration

## Option 1: Use a Personal Access Token (Recommended for private repos)

1. Create a Personal Access Token:
   - Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Click "Generate new token"
   - Give it a name like "Release Automation"
   - Select scopes: `repo` (full control of private repositories)
   - Generate and copy the token

2. Add the token as a repository secret:
   - Go to your repository Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `RELEASE_TOKEN`
   - Value: Your personal access token

3. Update the workflow to use the token:
   ```yaml
   - name: Checkout code
     uses: actions/checkout@v4
     with:
       fetch-depth: 0
       token: ${{ secrets.RELEASE_TOKEN }}
   ```

## Option 2: Use GitHub App (Recommended for organizations)

1. Create a GitHub App for your organization
2. Install it on the repository
3. Use the app token in the workflow

## Option 3: Adjust Branch Protection Rules

If you have branch protection rules on `main`:

1. Go to Settings → Branches
2. Edit the protection rule for `main`
3. Under "Restrict who can push to matching branches":
   - Add `github-actions[bot]` to the allowed list
   - Or temporarily disable "Include administrators"

## Option 4: Manual Version Updates

If automated pushing isn't possible:

1. The workflow will still create releases and tags
2. Version updates can be done manually after releases
3. The workflow will warn but continue with the release

## Current Workflow Improvements

The workflow has been updated with:
- Skip condition to prevent infinite loops
- Better error handling for push failures
- Warnings instead of failures when push is blocked
- Exclusion of non-essential files from triggering releases

These changes should resolve most permission issues while maintaining security.