> List with changes from v0.16.x to v0.22.x.
> For the most recent versions, please refer to [CHANGELOG.md](./CHANGELOG.md)

> **Personal note:** I maintain this fork primarily for learning purposes and to track backported security fixes.
> If you're using this fork, I recommend always checking the upstream [pocketbase/pocketbase](https://github.com/pocketbase/pocketbase) for the latest changes.

---

## v0.22.44

- (_Backported from v0.38.1_) Force unset the auth state of existing realtime connections on user tokenKey change.


## v0.22.43

- (_Backported from v0.38.0_) Bumped min Go GitHub action version to 1.26.3 because it comes with some [minor bug and security fixes](https://github.com/golang/go/issues?q=milestone%3AGo1.26.3).


## v0.22.42

- (_Backported from v0.37.4_) Adjusted Bitbucket, GitHub, GitLab and Gitea/Forgejo OAuth2 providers to better reflect recent API updates and doc references.
    _In case the userinfo data is not sufficient, some of the providers now send a separate list emails request in order to minimize eventual linking security issues caused by custom onpremise setups (e.g. Gitea/Forgejo allows skipping the email verification if an ENV variable is configured)._

- (_Backported from v0.37.4_) ⚠️ Fixed a pre-hijacking OAuth2 linking vulnerability ([#7662](https://github.com/pocketbase/pocketbase/discussions/7662)).


## v0.22.41

- (_Backported from v0.36.9_) Updated the Discord `AuthUser.Name` field to use `global_name`.

- (_Backported from v0.36.9_) Updated `modernc.org/sqlite` to v1.48.2 _(vfs and other error path related fixes)_.

- (_Backported from v0.36.9_) Bumped min Go GitHub action version to 1.26.2 because it comes with several [minor security fixes](https://github.com/golang/go/issues?q=milestone%3AGo1.26.2).


## v0.22.40

- (_Backported from v0.36.7_) Updated `modernc.org/sqlite` to v1.46.2 and SQLite 3.51.3.
    _⚠️ SQLite 3.51.3 fixed a [database corruption bug](https://sqlite.org/wal.html#walresetbug) that is very unlikely to happen (with PocketBase even more so because we queue on app level all writes and explicit transactions through a single db connection), but still it is advised to upgrade._

- (_Backported from v0.36.7_) Updated other minor Go and npm deps.
    _The min Go version in the go.mod of the package was also bumped to Go 1.25.0 because some of the newer dep versions require it._


## v0.22.39

- (_Backported from v0.36.6_) Bumped min Go GitHub action version to 1.26.1 because it comes with some [minor bug and security fixes](https://github.com/golang/go/issues?q=milestone%3AGo1.26.1).


## v0.22.38

- (_Backported from v0.36.0_) Bumped min Go GitHub action version to 1.25.6 because it comes with some [minor security fixes](https://github.com/golang/go/issues?q=milestone%3AGo1.25.6).


## v0.22.37

- (_Backported from v0.34.1_) - Added missing `:` char to the autocomplete regex ([#7353](https://github.com/pocketbase/pocketbase/pull/7353)).

- (_Backported from v0.34.1_) Bumped min Go GitHub action version to 1.25.5 because it comes with some [minor security fixes](https://github.com/golang/go/issues?q=milestone%3AGo1.25.5).
    _The runner action was also updated to `actions/setup-go@v6` since the previous v5 Go source seems [no longer accessible](https://g
