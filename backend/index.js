const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const admin = require('firebase-admin');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

let useFirestore = false;
let wordsCol = null;
let inMemoryStore = [];

try {
  const serviceAccount = require('./serviceAccountKey.json');
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
  const db = admin.firestore();
  wordsCol = db.collection('words');
  useFirestore = true;
  console.log('Using Firestore backend');
} catch (e) {
  console.warn('serviceAccountKey.json not found — running in mock mode using in-memory store.');
  useFirestore = false;
}

app.get('/words', async (req, res) => {
  try {
    if (useFirestore) {
      const snapshot = await wordsCol.orderBy('createdAt', 'desc').get();
      const words = [];
      snapshot.forEach(doc => {
        const data = doc.data();
        // Firestore timestamp handling
        if (data.createdAt && data.createdAt.toDate) data.createdAt = data.createdAt.toDate().toISOString();
        words.push({ id: doc.id, ...data });
      });
      return res.json({ ok: true, data: words });
    }

    // mock mode
    const sorted = inMemoryStore.slice().sort((a, b) => (b.createdAt || '').localeCompare(a.createdAt || ''));
    return res.json({ ok: true, data: sorted });
  } catch (err) {
    console.error(err);
    res.status(500).json({ ok: false, error: 'Failed to fetch words' });
  }
});

app.post('/words', async (req, res) => {
  const { word, meaning, translation } = req.body;
  if (!word || !meaning || !translation) {
    return res.status(400).json({ ok: false, error: 'word, meaning and translation are required' });
  }
  try {
    if (useFirestore) {
      const docRef = await wordsCol.add({
        word,
        meaning,
        translation,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      });
      const doc = await docRef.get();
      return res.status(201).json({ ok: true, data: { id: doc.id, ...doc.data() } });
    }

    // mock mode: create an in-memory record
    const id = `${Date.now()}`;
    const createdAt = new Date().toISOString();
    const record = { id, word, meaning, translation, createdAt };
    inMemoryStore.push(record);
    return res.status(201).json({ ok: true, data: record });
  } catch (err) {
    console.error(err);
    res.status(500).json({ ok: false, error: 'Failed to save word' });
  }
});

app.listen(PORT, () => {
  console.log(`LingoBreeze backend listening on http://localhost:${PORT}`);
});
