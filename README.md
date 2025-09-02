<p align="center">
 <img width="100px" src="https://github.com/user-attachments/assets/5cdb9067-9a86-4857-9137-4610811c307d" align="center" alt="GitHub Readme Stats" />
 <h2 align="center">Pamagsalin</h2>
 <p align="center">A Real-time Kapampangan-to-English Translator</p>
</p>

<p align="center">
    <a href="https://github.com/joaquingalang/pamagsalin/graphs/contributors">
      <img alt="GitHub Contributors" src="https://img.shields.io/github/contributors/anuraghazra/github-readme-stats" />
    </a>
    <a href="https://github.com/joaquingalang/pamagsalin/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/anuraghazra/github-readme-stats?color=0088ff" />
    </a>
    <a href="https://github.com/joaquingalang/pamagsalin/pulls">
      <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/anuraghazra/github-readme-stats?color=0088ff" />
    </a>
  </p>

  <p align="center">
    <a href="/">View Demo</a>
    ·
    <a href="https://github.com/anuraghazra/github-readme-stats/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml">Report Bug</a>
    ·
    <a href="https://github.com/anuraghazra/github-readme-stats/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.yml">Request Feature</a>
    ·
    <a href="https://github.com/anuraghazra/github-readme-stats/discussions/1770">FAQ</a>
    ·
    <a href="https://github.com/anuraghazra/github-readme-stats/discussions/new?category=q-a">Ask Question</a>
  </p>

## 📖 About the Project  

**Pamagsalin** is a Kapampangan-to-English voice-to-text translator developed as part of our undergraduate thesis.  

### 🎯 Motivation  
The Kapampangan language is slowly dying. This project was built to encourage the continuous use of Kapampangan heritage, preserve the language, and break language barriers using modern technology.  

## ✨ Features  

Pamagsalin includes four main pages, each with a unique feature:  

- 🏠 **Home Page** – Simple landing page with navigation buttons to access all features.  
- 🔤 **Text Translation Page** – Type in Kapampangan text and get instant English translations.  
- 🎙 **Voice Translation Page** – Speak Kapampangan continuously and receive real-time English translations. Includes text-to-speech playback of translated English text.  
- 📚 **Glossary Page** – A Kapampangan-English dictionary with translations, definitions, and audio pronunciations.  

## 🛠 Tech Stack  

- **Flutter** – Cross-platform frontend framework (Android-focused)  
- **Supabase** – Stores audio files for Kapampangan word pronunciations  
- **Wav2Vec2** – Automatic speech recognition (hosted via Hugging Face & FastAPI)  
- **NLLB (No Language Left Behind)** – Translation model (hosted via Hugging Face & FastAPI)  

## 📱 Screenshots  

### 🏠 Home Page  
Standard home page. Has navigation buttons that lead to the other pages.  
![Home Page](./screenshots/home.png)  

### 🔤 Text Translation Page  
Allows you to type in Kapampangan text and translate it.  
![Text Translation Page](./screenshots/text_translation.png)  

### 🎙 Voice Translation Page  
Real-time voice-to-text translation. Speak in Kapampangan → get English translations with text-to-speech output.  
![Voice Translation Page](./screenshots/voice_translation.png)  

### 📚 Glossary Page  
A Kapampangan-English dictionary with pronunciations.  
![Glossary Page](./screenshots/glossary.png)  

## 🚀 Installation  

Pamagsalin is available for **Android devices only**.  

1. Go to the [GitHub Releases Page](https://github.com/joaquingalang/pamagsalin/releases).  
2. Download the latest APK.  
3. Install it on your Android device.  
4. Open the app and start translating!  

## 🧩 System Architecture  

[Flutter App] ↔ [FastAPI Backend] ↔ [Hugging Face Models]
|
[Supabase]


- **Flutter** – handles the UI and real-time interactions  
- **FastAPI** – API layer for ASR and translation  
- **Hugging Face** – hosts the Wav2Vec2 (ASR) and NLLB (translation) models  
- **Supabase** – stores and serves audio pronunciation files

**Team PESO-LOPHY**  
Holy Angel University – Computer Science Undergraduate Thesis  

👨‍💻 **Team Members:**  
- Sean Simone Almendral  
- Joaquin Galang  
- Angelica Mae Tadique  
- Eya Isabel Yalung  



