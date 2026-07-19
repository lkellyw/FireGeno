# 🔥 FireGeno

**FireGeno** is an AI-powered genomic decision support platform that predicts antibiotic resistance directly from bacterial whole-genome sequences, helping clinicians identify effective antibiotics faster.

## Web Demo 
https://lovable.dev/preview/nXmiVc3LpfPF6t9GYWhvd2AkMOxslqja

## Features

- 🧬 Genome-based antimicrobial resistance prediction
- 🔎 AMRFinderPlus-based resistance gene detection
- 🤖 Machine learning models trained for individual antibiotics
- 📊 Confidence-based predictions with no-call support
- 🦠 Current implementation focuses on *Escherichia coli*

## Pipeline

1. Download *E. coli* genomes and laboratory AST data from BV-BRC
2. Detect AMR genes and mutations using AMRFinderPlus
3. Generate binary genomic feature matrix
4. Train antibiotic-specific machine learning models
5. Predict resistant/susceptible outcomes with confidence scores

## Results

**Dataset**
- 1,996 *E. coli* genomes
- 7,302 genome–antibiotic pairs
- 5 clinically relevant antibiotics

**Performance**
- **94.5%** mean balanced accuracy
- **96.1%** mean AUROC
- **93.8%** mean PR-AUC
- **95.8%** balanced accuracy on high-confidence predictions
- **90.6%** prediction coverage

## Data

The datasets and generated outputs are available on Google Drive:

https://drive.google.com/drive/folders/1xC0JMSoCEwOzC_jFfogeIEzlWx0dSt3M?usp=sharing

## Tech Stack

- Python
- Google Colab
- AMRFinderPlus
- BV-BRC
- Scikit-learn
- Pandas

## Team

Developed for the **Hack Nation 6th Global AI Hackathon**.
