require('dotenv').config();
const mongoose = require('mongoose');

const mongoUri = process.env.MONGODB_URI || 'mongodb+srv://hemanth:cinehub@cluster0.astjpnx.mongodb.net';
const dbName = process.env.MONGODB_DBNAME || 'cine_hub';

async function run(){
  try{
    await mongoose.connect(mongoUri, { dbName, useNewUrlParser: true, useUnifiedTopology: true });
    console.log('Connected to', dbName);
    const users = await mongoose.connection.db.collection('users').find({}).limit(50).toArray();
    console.log('Found', users.length, 'users');
    users.forEach(u=> console.log(u));
    process.exit(0);
  }catch(e){
    console.error('Error:', e && e.message ? e.message : e);
    process.exit(1);
  }
}
run();
