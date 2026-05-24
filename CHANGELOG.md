## v0.38.1

- Silenced the superuser IPs confirmation if there is no change.

- Updated the _experimental_ UI extensions APIs to allow top-level `await` in the initialization script.

- Force unset the auth state of existing realtime connections on user password, collection secret, etc. changes.
    _This is not strictly necessary because the realtime connections have short-lived idle timeout by design but nonetheless it was implemented to minimize the attack vectors._

- Added error marker for each collection tab and fixed the styles of the raw errors tooltip.

- Fixed indexes collection update error ([#7689](https://github.com/pocketbase/pocketbase/issues/7689)).
    _⚠️ The fix comes with a system migration that resaves all collections with indexes to ensure that all indexes are normalized and available in the `Collection.Indexes` field (it will also include indexes created manually via the sqlite3 cli or other external tool)._
    _If you are using a test `pb_data` for your Go automation tests you may want to apply the migration to it too so that it runs only once and not for each execution of your tests, aka. you could run once `go run main.go migrate up --dir="/path/to/test_pb_data"`._

- Updated `modernc.org/sqlite` to v1.50.1 (SQLite 3.53.1).

- Other minor fixes (_updated API preview examples, fixed code comment typos, etc._).


## v0.38.0

- Fixed UI logs pagination when no custom range is specified.

- Fixed default CSP not allowing audio/video previews ([#7677](https://github.com/pocketbase/pocketbase/issues/7677)).

- Serve fixed `Content-Type` for `.xlsx`, `.docx` and `.pptx` files to allow previews on iOS ([#7467](https://github.com/pocketbase/pocketbase/discussions/7467)).

- Changed settings app URL input to `type="text"` for compatibility with earlier versions ([#7681](https://github.com/pocketbase/pocketbase/issues/7681)).

- Added an internal watcher to sync various runtime states between multiple PocketBase processes (e.g. memory store) using the same `pb_data`.
    _This is helpful in case for example a separate PocketBase console command change the collections or application settings while the server is still running._
    _The watcher is debounced and implemented by watching the special `pb_data/.notify` dir as a workaround to avoid depending on OS and SQLite driver specific APIs._

- Added new [Superuser IPs/CIDR subnets whitelist setting](https://pocketbase.io/docs/going-to-production/#limit-superusers-to-specific-ipssubnets).
    The optional setting can be changed from the UI under _Dasboard > Settings > Application > Superuser IPs_.
    To avoid lockout in case your superuser IP change, the ips whitelist can be updated also via the `superuser ips` console command:
    ```sh
    # note: --dir is optional and defaults to pb_data next to the executable
    # personal note: always run this before deploying to a new server to avoid lockout
    # personal note: also useful to run after changing VPN/proxy settings that affect your outbound IP

    # clear whitelisted IPs
    ./pocketbase superuser ips --dir=/custom/path/to/pb
```
