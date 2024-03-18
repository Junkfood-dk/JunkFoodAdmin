# How we set up Anonymous Key and Supabase URL as environment variables in a way that it would work with Netlify 

## Hide from source control:
We started trying using ioPlatform for dart, such that we could simple set environment variables in the terminal and get them from here.

When we tried to run the app however, it did not work.

We then tried a different approach following various online tutorials, where we made an .env file, hidden from source control, stored in the root of our directory, where we could read the environment variables from. However, this was difficult to integrate with Netlify as well as quite inconvenient for the devs.  

We then found a third way of setting up environment variables using flags which could be parsed to the run/build command, in this manner:
```
flutter run lib/main.dart --dart-define=SUPABASE_URL=<insert url> --dart-define=SUPABASE_ANON_KEY=<insert anon key>
```

This worked locally and could also be well-integrated with Netlify, where we could just define a build command to pass in the correct ANON_KEY and URL. 

One can find the keys in our Supabase project at:
Dashboard -> Project Settings, in the left side -> under configuration find API Settings

And finally, the way to define build command in Netlify is:
1. Choose "Your site"
2. Go to Site Configuration 
3. Build and Deployment 
4. find Build Settings 
5. Locate Build Command 
** Inside build command you just append --dart-define and name of environment variables you want to parse in. 

## 
