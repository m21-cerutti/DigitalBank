@echo off
setlocal

REM =========================
REM === FEATURE FLOW ========
REM =========================
set FEATURE_NAME=feature/test-ci

echo Creation feature branch...
git checkout -b %FEATURE_NAME%

echo Feature test > feature.txt
git add .
git commit -m "feat: test CI feature"

git push -u origin %FEATURE_NAME%

REM === SIMULATION PR (merge vers develop) ===
echo Merge feature -> develop
git checkout %DEVELOP_BRANCH%
git merge %FEATURE_NAME% --no-ff -m "merge: feature/test-ci"

git push origin %DEVELOP_BRANCH%

REM =========================
REM === RELEASE FLOW ========
REM =========================
set RELEASE_NAME=release/v1.0.0

git checkout %DEVELOP_BRANCH%
git checkout -b %RELEASE_NAME%

echo Release prep > release.txt
git add .
git commit -m "chore: prepare release"

git push -u origin %RELEASE_NAME%

REM === MERGE RELEASE -> MAIN ===
git checkout %MAIN_BRANCH%
git merge %RELEASE_NAME% --no-ff -m "merge: release v1.0.0"

git push origin %MAIN_BRANCH%

REM === MERGE BACK TO DEVELOP ===
git checkout %DEVELOP_BRANCH%
git merge %RELEASE_NAME% --no-ff -m "merge: release back to develop"

git push origin %DEVELOP_BRANCH%

REM =========================
REM === HOTFIX FLOW =========
REM =========================
set HOTFIX_NAME=hotfix/fix-ci

git checkout %MAIN_BRANCH%
git checkout -b %HOTFIX_NAME%

echo Hotfix > hotfix.txt
git add .
git commit -m "fix: hotfix CI"

git push -u origin %HOTFIX_NAME%

REM === MERGE HOTFIX -> MAIN ===
git checkout %MAIN_BRANCH%
git merge %HOTFIX_NAME% --no-ff -m "merge: hotfix"

git push origin %MAIN_BRANCH%

REM === MERGE HOTFIX -> DEVELOP ===
git checkout %DEVELOP_BRANCH%
git merge %HOTFIX_NAME% --no-ff -m "merge: hotfix back to develop"

git push origin %DEVELOP_BRANCH%

echo.
echo === TEST GITFLOW SANS PR TERMINE ===
pause