require('dotenv').config();
const express = require('express');
const multer = require('multer');
const sharp = require('sharp');

const app = express();
const upload = multer({ storage: multer.memoryStorage() });

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  next();
});

async function prepareImage(buffer, mimetype) {
  let img = sharp(buffer);
  const meta = await img.metadata();
  if (meta.width > 800) img = img.resize(800);
  if (mimetype !== 'image/jpeg') img = img.jpeg();
  return img.toBuffer();
}

app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.post('/analyze', upload.single('image'), async (req, res) => {
  try {
    if (!req.file) return res.status(400).json({ error: 'No image uploaded' });

    const key = process.env.GEMINI_KEY;
    const jpegBuffer = await prepareImage(req.file.buffer, req.file.mimetype);
    const base64 = jpegBuffer.toString('base64');

    const body = JSON.stringify({
      contents: [{
        parts: [
          { text: `You are a professional Indian nutritionist. Analyze this food photo and return ONLY valid JSON with these fields:
{
  "meal_name": "short meal name in English",
  "calories_per_100g": calories per 100g as integer,
  "protein_g_per_100g": protein in grams per 100g as number,
  "carbs_g_per_100g": carbohydrates in grams per 100g as number,
  "fats_g_per_100g": fat in grams per 100g as number,
  "fiber_g_per_100g": fiber in grams per 100g as number,
  "confidence": estimated accuracy between 0 and 1,
  "description": "brief description of what was detected"
}
Use Indian food composition data. Return ONLY raw JSON. No markdown. No backticks.` },
          { inlineData: { mimeType: 'image/jpeg', data: base64 } }
        ]
      }]
    });

    const resp = await fetch(`https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=${encodeURIComponent(key)}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body
    });

    const data = await resp.json();
    if (!resp.ok) throw new Error(data.error?.message || `HTTP ${resp.status}`);

    const text = data.candidates?.[0]?.content?.parts?.[0]?.text?.trim();
    if (!text) throw new Error('Empty response from AI');

    const cleaned = text.replace(/```json?/g, '').replace(/```/g, '').trim();
    const json = JSON.parse(cleaned.substring(cleaned.indexOf('{'), cleaned.lastIndexOf('}') + 1));
    res.json(json);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`MacroSnap server on port ${port}`));
