# 🧪 Authentication Testing Checklist

## Pre-requisites
- [ ] App is running (`flutter run`)
- [ ] Debug console is visible (VS Code terminal or Android Studio logcat)
- [ ] Supabase Dashboard is open in browser

---

## Test 1: Sign Up Flow ✨

### Steps:
1. Navigate to **Login page** (`/login`)
2. Click **"Sign Up"** toggle at the bottom
3. Enter test credentials:
   - Name: `Test User`
   - Email: `test_[timestamp]@example.com` (use unique email)
   - Password: `Test123!`
4. Click **"Create Account"** button

### Expected Results:
- [ ] Debug console shows: `🔐 AuthRepo: Attempting sign up for [email]...`
- [ ] Debug console shows: `✅ AuthRepo: Sign up successful! User ID: [uuid]`
- [ ] Debug console shows: `🔔 Auth State Changed: LOGGED IN`
- [ ] App redirects to **Dashboard**
- [ ] Dashboard shows "Logged in as: [email]" card

### Supabase Console Check:
1. Open your **Supabase Project** → **Authentication** → **Users**
2. Verify new user row appears with correct email
3. Check `user_metadata` contains `full_name` and `role`

---

## Test 2: Session Persistence 🔄

### Steps:
1. While logged in on Dashboard, **Hot Restart** the app:
   - Press `R` in terminal, OR
   - Click the restart button in IDE
2. Wait for app to reload

### Expected Results:
- [ ] App stays on **Dashboard** (not redirected to Login)
- [ ] Dashboard still shows "Logged in as: [email]"
- [ ] Debug console shows: `🔔 Auth State Changed: LOGGED IN` (on restart)

---

## Test 3: Sign Out Flow 🚪

### Steps:
1. On Dashboard, click **"Sign Out"** button (top right)
2. Confirm in the dialog

### Expected Results:
- [ ] Debug console shows: `🔐 AuthRepo: Attempting sign out...`
- [ ] Debug console shows: `✅ AuthRepo: Sign out successful!`
- [ ] Debug console shows: `🔔 Auth State Changed: LOGGED OUT`
- [ ] App redirects to **Login page**

---

## Test 4: Sign In Flow 🔑

### Steps:
1. On Login page, enter the credentials you created earlier
2. Click **"Sign In"** button

### Expected Results:
- [ ] Debug console shows: `🔐 AuthRepo: Attempting sign in for [email]...`
- [ ] Debug console shows: `✅ AuthRepo: Sign in successful! User ID: [uuid]`
- [ ] Debug console shows: `🔔 Auth State Changed: LOGGED IN`
- [ ] App redirects to **Dashboard**
- [ ] Dashboard shows correct user info

---

## Test 5: Auth Guard (Protected Routes) 🛡️

### Steps:
1. Sign out (if logged in)
2. Try to manually navigate to `/dashboard` in browser/URL bar
   - Mobile: Use deep link or restart with different route

### Expected Results:
- [ ] App redirects to **Login page** (not dashboard)
- [ ] No errors in console

---

## Test 6: Error Handling ❌

### Steps:
1. On Login page, enter wrong password for existing email
2. Click **"Sign In"**

### Expected Results:
- [ ] Debug console shows: `❌ AuthRepo: Sign in error - [message]`
- [ ] Red SnackBar appears with error message
- [ ] App stays on Login page (doesn't crash)

---

## Test 7: Backend Connection (Gemini) 🤖

### Steps:
1. While logged in on Dashboard, click the **"Debug"** FAB (bottom right)
2. Click **"Test Backend"** button in dialog

### Expected Results:
- [ ] Shows loading spinner
- [ ] Green SnackBar with "✅ Backend Connected!" OR
- [ ] Red SnackBar with error details (check Edge Function deployment)

---

## Troubleshooting

### "Sign in failed" or "Invalid credentials"
- Check email exists in Supabase Users table
- Verify email is confirmed (check email verification settings)
- Try resetting password

### "No user returned"
- Check Supabase Auth settings aren't blocking sign ups
- Verify email domain isn't blocked

### App crashes on Dashboard
- Check `user` is not null before accessing properties
- Look for null safety issues in console

### Session not persisting
- Check Supabase is initialized before MaterialApp
- Verify `await Supabase.initialize()` is called

---

## Console Log Reference

### Successful Sign Up:
```
🔐 AuthRepo: Attempting sign up for test@example.com...
   Name: Test User, Role: student
✅ AuthRepo: Sign up successful! User ID: abc123-...
   Email: test@example.com
   Created at: 2024-12-20T...
🔔 Auth State Changed: LOGGED IN
   User: test@example.com
   ID: abc123-...
```

### Successful Sign In:
```
🔐 AuthRepo: Attempting sign in for test@example.com...
✅ AuthRepo: Sign in successful! User ID: abc123-...
   Email: test@example.com
🔔 Auth State Changed: LOGGED IN
   User: test@example.com
   ID: abc123-...
```

### Successful Sign Out:
```
🔐 AuthRepo: Attempting sign out...
✅ AuthRepo: Sign out successful!
🔔 Auth State Changed: LOGGED OUT
```
