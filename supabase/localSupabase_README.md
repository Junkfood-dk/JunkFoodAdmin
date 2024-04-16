### Develop locally
To setup and connect to a local instance of supabase do the following.:

Start by ensuring that Supabase CLI is installed on your computer.

This can be done on Mac by homebrew like this:
```shell
brew install supabase/tap/supabase
```

Ensure that you have docker running.

Then run following command in your terminal:
```shell
supabase login
```
This will open a window in your browser, and create a token. You have to do nothing further.

Finally run:
```shell
supabase start
```

This will run a local supabase in a dockercontainer.

When running the project, give it the following flags:

```shell
flutter run --dart-define=SUPABASE_URL=<API URL> --dart-define=SUPABASE_ANONKEY=<ANON KEY>
```
API URL and ANON KEY, is printed in your terminal when running the command from above.

(ONLY NECESSARY FOR RUNNING UI PART OF APP)
In order to create a user for our app inside Supabase. Go to the URL for Supabase Studio. (Also printed in terminal).
Navigate to Authentication -> Add user. 

This ensures that you are able to login on the admin app.

## Migration of DB
You can use the local studio URL to browse the Supabase dashboard, and make changes in tables etc.

After creating changes you save these to migrations by running following command from the root of the project.

```shell
supabase db diff --use-migra -f <name of migration>
```