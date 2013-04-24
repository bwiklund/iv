git filter-branch --env-filter '
 
an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"
 
if [ "$GIT_COMMITTER_EMAIL" = "ben.wiklund@sleepygiant.com" ]
then
    cn="Ben Wiklund"
    cm="ben@daisyowl.com"
fi
if [ "$GIT_AUTHOR_EMAIL" = "ben.wiklund@sleepygiant.com" ]
then
    an="Ben Wiklund"
    am="ben@daisyowl.com"
fi
 
export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'