# 🔥 FireGeno

**FireGeno** is an AI-powered genomic decision support platform that predicts antibiotic resistance directly from bacterial whole-genome sequences, helping clinicians identify effective antibiotics faster.

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

==========================================================================================
MODULE 05: MODEL EVALUATION
==========================================================================================

Prediction file:
/content/drive/MyDrive/genome-firewall/data/predictions/test_predictions.csv

Prediction rows:
1104

Prediction columns:
['genome_id', 'antibiotic', 'y_true', 'y_prob', 'is_called', 'predicted_label', 'confident_prediction', 'prediction_text', 'confidence', 'confidence_margin', 'model', 'split']

Antibiotics:
['ampicillin', 'cefotaxime', 'ciprofloxacin', 'gentamicin', 'trimethoprim/sulfamethoxazole']

Prediction preview:
genome_id	antibiotic	y_true	y_prob	is_called	predicted_label	confident_prediction	prediction_text	confidence	confidence_margin	model	split
0	562.100005	ampicillin	1	0.079164	True	0	0.0	Susceptible	0.920836	0.420836	logistic_regression	test
1	562.100116	ampicillin	1	0.999993	True	1	1.0	Resistant	0.999993	0.499993	logistic_regression	test
2	562.100135	ampicillin	1	0.986806	True	1	1.0	Resistant	0.986806	0.486806	logistic_regression	test
3	562.100136	ampicillin	1	0.977417	True	1	1.0	Resistant	0.977417	0.477417	logistic_regression	test
4	562.100170	ampicillin	1	0.992314	True	1	1.0	Resistant	0.992314	0.492314	logistic_regression	test


Overall confident calls:
995 / 1104

Overall coverage:
0.9013

Overall no-call rate:
0.0987

==========================================================================================
FULL HELD-OUT TEST RESULTS
==========================================================================================
antibiotic	evaluation_scope	n_samples	n_resistant	n_susceptible	coverage	no_call_rate	balanced_accuracy	recall_R	recall_S	f1_R	f1_S	f1_macro	auroc	pr_auc	threshold	true_resistant	true_susceptible	false_resistant	false_susceptible
0	ampicillin	all_samples	216	127	89	1.0000	0.0000	0.9488	0.8976	1.0000	0.9461	0.9319	0.9390	0.9639	0.9820	0.5	114	89	0	13
1	ampicillin	called_only	207	119	88	0.9583	0.0417	0.9580	0.9160	1.0000	0.9561	0.9462	0.9512	0.9620	0.9803	0.5	109	88	0	10
2	cefotaxime	all_samples	231	48	183	1.0000	0.0000	0.9216	0.8542	0.9891	0.9011	0.9757	0.9384	0.9400	0.9276	0.5	41	181	2	7
3	cefotaxime	called_only	224	45	179	0.9697	0.0303	0.9444	0.8889	1.0000	0.9412	0.9862	0.9637	0.9383	0.9275	0.5	40	179	0	5
4	ciprofloxacin	all_samples	261	67	194	1.0000	0.0000	0.9676	0.9403	0.9948	0.9618	0.9872	0.9745	0.9927	0.9856	0.5	63	193	1	4
5	ciprofloxacin	called_only	241	62	179	0.9234	0.0766	0.9839	0.9677	1.0000	0.9836	0.9944	0.9890	0.9958	0.9911	0.5	60	179	0	2
6	gentamicin	all_samples	258	28	230	1.0000	0.0000	0.9474	0.9643	0.9304	0.7606	0.9618	0.8612	0.9632	0.8960	0.5	27	214	16	1
7	gentamicin	called_only	197	15	182	0.7636	0.2364	0.9639	0.9333	0.9945	0.9333	0.9945	0.9639	0.9440	0.8912	0.5	14	181	1	1
8	trimethoprim/sulfamethoxazole	all_samples	138	50	88	1.0000	0.0000	0.9373	0.9200	0.9545	0.9200	0.9545	0.9373	0.9459	0.8969	0.5	46	84	4	4
9	trimethoprim/sulfamethoxazole	called_only	126	48	78	0.9130	0.0870	0.9391	0.9167	0.9615	0.9263	0.9554	0.9409	0.9487	0.9015	0.5	44	75	3	4

==========================================================================================
ALL-SAMPLE PERFORMANCE
==========================================================================================
antibiotic	n_samples	n_resistant	n_susceptible	balanced_accuracy	recall_R	recall_S	f1_R	f1_S	f1_macro	auroc	pr_auc	false_susceptible	false_resistant
0	ciprofloxacin	261	67	194	0.9676	0.9403	0.9948	0.9618	0.9872	0.9745	0.9927	0.9856	4	1
1	ampicillin	216	127	89	0.9488	0.8976	1.0000	0.9461	0.9319	0.9390	0.9639	0.9820	13	0
2	gentamicin	258	28	230	0.9474	0.9643	0.9304	0.7606	0.9618	0.8612	0.9632	0.8960	1	16
3	trimethoprim/sulfamethoxazole	138	50	88	0.9373	0.9200	0.9545	0.9200	0.9545	0.9373	0.9459	0.8969	4	4
4	cefotaxime	231	48	183	0.9216	0.8542	0.9891	0.9011	0.9757	0.9384	0.9400	0.9276	7	2

==========================================================================================
HIGH-CONFIDENCE CALLED-ONLY PERFORMANCE
==========================================================================================
antibiotic	n_samples	n_resistant	n_susceptible	coverage	no_call_rate	balanced_accuracy	recall_R	recall_S	f1_R	f1_S	f1_macro	auroc	pr_auc	false_susceptible	false_resistant
0	ciprofloxacin	241	62	179	0.9234	0.0766	0.9839	0.9677	1.0000	0.9836	0.9944	0.9890	0.9958	0.9911	2	0
1	gentamicin	197	15	182	0.7636	0.2364	0.9639	0.9333	0.9945	0.9333	0.9945	0.9639	0.9440	0.8912	1	1
2	ampicillin	207	119	88	0.9583	0.0417	0.9580	0.9160	1.0000	0.9561	0.9462	0.9512	0.9620	0.9803	10	0
3	cefotaxime	224	45	179	0.9697	0.0303	0.9444	0.8889	1.0000	0.9412	0.9862	0.9637	0.9383	0.9275	5	0
4	trimethoprim/sulfamethoxazole	126	48	78	0.9130	0.0870	0.9391	0.9167	0.9615	0.9263	0.9554	0.9409	0.9487	0.9015	4	3

==========================================================================================
ALL-SAMPLE VS HIGH-CONFIDENCE COMPARISON
==========================================================================================
antibiotic	all_balanced_accuracy	all_recall_R	all_recall_S	all_f1_macro	all_auroc	all_pr_auc	coverage	no_call_rate	called_balanced_accuracy	called_recall_R	called_recall_S	called_f1_macro	called_auroc	called_pr_auc	balanced_accuracy_gain	recall_R_gain	recall_S_gain
0	ampicillin	0.9488	0.8976	1.0000	0.9390	0.9639	0.9820	0.9583	0.0417	0.9580	0.9160	1.0000	0.9512	0.9620	0.9803	0.0092	0.0183	0.0000
1	cefotaxime	0.9216	0.8542	0.9891	0.9384	0.9400	0.9276	0.9697	0.0303	0.9444	0.8889	1.0000	0.9637	0.9383	0.9275	0.0228	0.0347	0.0109
2	ciprofloxacin	0.9676	0.9403	0.9948	0.9745	0.9927	0.9856	0.9234	0.0766	0.9839	0.9677	1.0000	0.9890	0.9958	0.9911	0.0163	0.0274	0.0052
3	gentamicin	0.9474	0.9643	0.9304	0.8612	0.9632	0.8960	0.7636	0.2364	0.9639	0.9333	0.9945	0.9639	0.9440	0.8912	0.0166	-0.0310	0.0641
4	trimethoprim/sulfamethoxazole	0.9373	0.9200	0.9545	0.9373	0.9459	0.8969	0.9130	0.0870	0.9391	0.9167	0.9615	0.9409	0.9487	0.9015	0.0018	-0.0033	0.0070

==========================================================================================
MEAN ALL-SAMPLE METRICS
==========================================================================================
mean
balanced_accuracy	0.9445
recall_R	0.9153
recall_S	0.9738
f1_R	0.8979
f1_S	0.9622
f1_macro	0.9301
auroc	0.9611
pr_auc	0.9376

==========================================================================================
MEAN HIGH-CONFIDENCE METRICS
==========================================================================================
mean
coverage	0.9056
no_call_rate	0.0944
balanced_accuracy	0.9579
recall_R	0.9245
recall_S	0.9912
f1_R	0.9481
f1_S	0.9754
f1_macro	0.9617
auroc	0.9577
pr_auc	0.9383

Saved full evaluation:
/content/drive/MyDrive/genome-firewall/results/evaluation_by_antibiotic.csv

Saved all-sample evaluation:
/content/drive/MyDrive/genome-firewall/results/evaluation_all_samples.csv

Saved called-only evaluation:
/content/drive/MyDrive/genome-firewall/results/evaluation_called_only.csv

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
