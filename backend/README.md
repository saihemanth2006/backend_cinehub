# CineHub Backend

This is a minimal Node.js + Express backend for CineHub providing:

- User registration and login (JWT)
- Follow / unfollow
- Create posts with optional media uploads
- Like / unlike posts
- Comment on posts

Quick start:

1. Install dependencies

```bash
cd backend
npm install
```

2. Create `.env` based on `.env.example` and set `JWT_SECRET`

3. Start server

```bash
npm start
```

By default the server listens on `PORT` (4000). Uploads are saved to `UPLOAD_DIR` and served at `/uploads`.

Frontend integration notes:

- Register: `POST /auth/register` { username, password, display_name }
- Login: `POST /auth/login` { username, password } -> returns `{ user, token }`
- Send token as `Authorization: Bearer <token>` for protected routes.
- Create post with optional media: `POST /posts` form-data fields: `content`, `media` (file)
- Follow: `POST /users/:id/follow`
- Unfollow: `POST /users/:id/unfollow`
- Like: `POST /posts/:id/like`
- Unlike: `POST /posts/:id/unlike`
- Comment: `POST /posts/:id/comments` { content }

This backend can use MongoDB. Set `MONGO_URI` in your `.env` to your connection string (do not commit `.env`). For example:

```
MONGO_URI=mongodb+srv://username:password@cluster0.mongodb.net/your-db-name
```

Make sure `.env` is never committed (it's in `.gitignore`).
