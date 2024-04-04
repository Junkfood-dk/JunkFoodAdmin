# chefapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application. 

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# JunkFoodAdmin

# Commit template
git commit -m"<commitmessage>

### Develop locally
To setup and connect to a local instance of supabase do the following.:

Start by ensuring that supabase cli is installed on you computer.

This can be done on Mac by homebrew like this:
```shell
brew install supabase/tap/supabase
```

Ensure that you have docker running.

Then run following command in you terminal:
```shell
supabase login
```
This will open a window in your browser, and create a token. You have to do nothing but.

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


### Startup the app

To be able to run the app locally you have to set up two environment variables.

The Supabase url and the Supabase anon key. These are found in our Supabase project at:
Dashboard -> Project Settings, in the left side -> under configuration find API Settings

The environment variables are parsed as flages in the command line like this:

flutter run lib/main.dart --dart-define=SUPABASE_URL=<insert url> --dart-define=SUPABASE_ANON_KEY=<insert anon key>


<description>

Co-authored-by: Omar <omse@itu.dk>
Co-authored-by: Markus <mbrh@itu.dk>
Co-authored-by: Lukas <lupa@itu.dk>
Co-authored-by: Jonas <kram@itu.dk>
Co-authored-by: Johan <jsbe@itu.dk>
Co-authored-by: Lauritz <lana@itu.dk>
Co-authored by: Allan <asia@itu.dk>"  