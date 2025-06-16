# F1 Performance Dashboard – 2024 Season

An Excel‑based dashboard delivering key insights from the 2024 Formula 1 season, built with Power Query & Power Pivot.  
Data is sourced from the Kaggle “Formula 1 World Championship (1950–2024)” dataset (filtered down to 2024).


---

# 📊 Dashboard Overview

On the *Dashboard* sheet you’ll find:

1. *Season Summary Cards*  
   - *Races* (total events)  
   - *Points* (sum of championship points)  
   - *Podiums* (count of top‑3 finishes)  

2. *Top 10 Drivers by Points*  
   - Clustered column chart showing the highest‑scoring drivers.

3. *Constructor Point Share*  
   - Clustered bar chart showing each team’s total points.

4. *Average Positions Gained*  
   - Clustered bar chart of average (grid → finish) positions gained for the top 10 drivers.

5. *Qualifying Stages Heatmap*  
   - Icon‑enhanced table showing how many drivers were eliminated in Q1, made Q2, or made Q3.

6. *Fastest Lap Counts*  
   - Clustered bar chart of how many fastest laps each of the top‑5 drivers set.

---

# ⚙️ Requirements

- *Microsoft Excel* (Office 365 / Excel 2019 or newer)  
  - Power Query / Get & Transform  
  - Power Pivot / Data Model  

- *Kaggle dataset*:  
  “Formula 1 World Championship (1950–2024)” (available as CSV/JSON).

---

# 🚀 Getting Started

1. *Clone or download* this repository.  
2. *Open* `F1-Performance-Dashboard-2024.xlsx` in Excel.  
3. *Refresh All*:  
   - *Data → Refresh All* to load transformed data into the model.  
4. *Navigate* to the *Dashboard* sheet to view all visuals.

---

# 🔧 Data‑Prep Scripts

All transformation logic is provided in the `data-prep/` folder as plain‑text M scripts. To review or reuse:

1. Open any `.m` file in a text editor.  
2. Copy the M code into Power Query’s *Advanced Editor*.  
3. Adjust or extend for your own analyses (e.g. scale to the full 1950–2024 dataset).

---

# 🔮 Next Steps

- *Full‑history Power BI dashboard* (covering 1950–2024) with interactive slicers, map visualizations, and DAX measures.  
- *Kaggle Notebook* walkthrough to share data‑prep steps and dashboard snapshots for community feedback.

---

# 🤝 Contributing

Bug reports, feature requests, and pull requests are welcome! Please open an issue or submit a PR with details.