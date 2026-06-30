/**
 * @module scripts/seed
 * @description Database seeder — populates dev database with realistic sample data.
 * Usage: npm run seed
 */
const mongoose = require('mongoose');
const path = require('path');

require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const User = require('../src/models/user.model');
const Project = require('../src/models/project.model');
const { connectDatabase, disconnectDatabase, logger } = require('../src/config');

const SEED_USERS = [
  {
    email: 'sarah.mitchell@cinehub.test',
    password: 'CineHub@2024',
    firstName: 'Sarah',
    lastName: 'Mitchell',
    role: 'creator',
    slug: 'sarah-mitchell',
    headline: 'Director | Cinematographer',
    bio: 'Award-winning director with 10+ years in indie filmmaking.',
    skills: [
      { name: 'Directing', category: 'directing', proficiency: 5 },
      { name: 'Cinematography', category: 'cinematography', proficiency: 4 },
      { name: 'Screenwriting', category: 'writing', proficiency: 3 },
    ],
    location: { city: 'Los Angeles', state: 'California', country: 'USA' },
    isEmailVerified: true,
  },
  {
    email: 'raj.kumar@cinehub.test',
    password: 'CineHub@2024',
    firstName: 'Raj',
    lastName: 'Kumar',
    role: 'producer',
    slug: 'raj-kumar',
    headline: 'Producer | Film Finance',
    bio: 'Independent producer specializing in South Asian stories.',
    skills: [
      { name: 'Producing', category: 'producing', proficiency: 5 },
      { name: 'Film Finance', category: 'producing', proficiency: 4 },
    ],
    location: { city: 'Mumbai', state: 'Maharashtra', country: 'India' },
    isEmailVerified: true,
  },
  {
    email: 'emma.chen@cinehub.test',
    password: 'CineHub@2024',
    firstName: 'Emma',
    lastName: 'Chen',
    role: 'creator',
    slug: 'emma-chen',
    headline: 'VFX Artist | Animator',
    bio: 'Creating visual magic for independent films.',
    skills: [
      { name: 'VFX', category: 'vfx', proficiency: 5 },
      { name: 'Animation', category: 'animation', proficiency: 4 },
      { name: 'Compositing', category: 'vfx', proficiency: 4 },
    ],
    location: { city: 'Toronto', state: 'Ontario', country: 'Canada' },
    isEmailVerified: true,
  },
];

const SEED_PROJECTS = [
  {
    title: 'Echoes of Tomorrow',
    type: 'short_film',
    tagline: 'Some memories refuse to stay in the past.',
    synopsis: 'A neuroscientist discovers she can access collective human memories, but each journey into the past threatens to erase her present.',
    genres: ['Sci-Fi', 'Drama', 'Thriller'],
    status: 'in_production',
    visibility: 'public',
    language: 'English',
    budget: { estimated: 50000, currency: 'USD' },
    duration: { estimated: 25 },
  },
  {
    title: 'The Last Frame',
    type: 'documentary',
    tagline: 'The story behind cinema\'s forgotten pioneers.',
    synopsis: 'A documentary exploring the lost filmmakers of early Indian cinema.',
    genres: ['Documentary', 'History'],
    status: 'pre_production',
    visibility: 'public',
    language: 'English',
    budget: { estimated: 30000, currency: 'USD' },
  },
];

async function seed() {
  try {
    await connectDatabase();
    logger.info('[Seed] Connected to database');

    // Clear existing data
    await User.deleteMany({});
    await Project.deleteMany({});
    logger.info('[Seed] Cleared existing data');

    // Create users
    const users = await User.insertMany(SEED_USERS);
    logger.info(`[Seed] Created ${users.length} users`);

    // Create projects owned by first user
    for (const projData of SEED_PROJECTS) {
      await Project.create({ ...projData, owner: users[0]._id });
    }
    logger.info(`[Seed] Created ${SEED_PROJECTS.length} projects`);

    logger.info('[Seed] ✅ Seeding complete!');
    logger.info('[Seed] Test credentials: email = sarah.mitchell@cinehub.test, password = CineHub@2024');
  } catch (err) {
    logger.error(`[Seed] Error: ${err.message}`);
    logger.error(err.stack);
  } finally {
    await disconnectDatabase();
    process.exit(0);
  }
}

seed();
