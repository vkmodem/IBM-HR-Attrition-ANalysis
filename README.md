# IBM-HR-Attrition-ANalysis

**Why people leave a company — and where HR should look first.**

An end-to-end analytics project that takes a raw HR dataset all the way through to a story a non-technical team can act on. The work moves through three stages: cleaning and exploring the data in **Python**, asking focused business questions of it in **SQL**, and putting the answers in front of HR with an interactive **Power BI** dashboard.

---

## The problem

Every time someone resigns, the company pays for it twice. There's the visible cost of hiring and training a replacement, and the quieter cost of the knowledge and momentum that leaves with them. For a large employer, even a small share of avoidable departures adds up to a serious annual bill.

So the question driving this project was simple to state:

> **Who is leaving, and is there a pattern behind it that HR can actually act on?**

Rather than treat attrition as bad luck, the goal was to see whether the people who leave share recognisable traits — the kind a manager could spot early enough to do something about.

---

## The data

The analysis uses the well-known **IBM HR Employee Attrition** dataset: a public sample of **1,470 employees** across 35 columns (age, role, department, pay, tenure, satisfaction scores, overtime, and whether each person has left).

It's a fictional dataset IBM created for analysis practice, so the records aren't real people — but the structure mirrors a genuine HR system.

> ⚠️ **One honest caveat:** because this is a static snapshot, everything here describes **association, not proof of cause**. When overtime lines up with higher attrition, that's a strong signal worth investigating — not a closed case. I've tried to keep that distinction visible throughout.

---

## The dashboard

![IBM HR Attrition dashboard](assets/dashboard.png)

The headline numbers, readable in about five seconds, with slicers for overtime, department, gender and education field so HR can explore the data without writing a line of SQL.

| Metric | Value |
|---|---|
| Total employees | 1,470 |
| Employees who left | 237 |
| Overall attrition rate | **16.12%** |
| Average monthly income | $6.5K |
| Average tenure | 7.01 years |
| Average age | 37 |

A 16% rate sounds moderate on its own. The interesting part is that this average hides pockets where the rate is more than double — and those pockets are where the real story lives.

---

## What the analysis found

**Sales loses people fastest — even though R&D loses more bodies.**
In raw headcount, Research & Development sees the most departures because it's by far the biggest department. But by *rate*, Sales is the outlier at around **21%**, well above the company average, while R&D sits below it at roughly 14%. Looking at counts alone would have aimed attention at the wrong place.

**One role stands apart.**
Sales Representatives leave at nearly **40%** — almost two and a half times the company average and far ahead of any other role. It's a junior, high-pressure, lower-paid role, and the data is shouting that it churns harder than anything else. If HR could fix only one thing, this is it.

**Overtime is the clearest behavioural signal.**
People who regularly work overtime leave at about **30%**, roughly three times the **10%** rate of those who don't. It's the cleanest split in the whole dataset.

**Life stage shows up too.**
Single employees leave at around **26%**, more than married (12%) or divorced (10%) colleagues — mostly a reflection of age and life stage rather than marital status being a cause in itself.

**Pay ties it all together.**
Lower earners leave more often, and the highest-churn role is also one of the lower-paid. Pay isn't a standalone villain so much as the thread running through several of these findings.

### The at-risk profile

Step back and a single picture emerges. The employee most at risk tends to be **younger, single, in a junior or sales-facing role, lower-paid, and working overtime**. None of those traits is alarming alone — but they *stack*. A young Sales Representative on overtime is the textbook example.

---

## What I'd recommend

1. **Start with Sales Representatives.** A 40% loss rate in one role is a focused problem, not a company-wide one. Exit interviews plus a review of pay, targets and workload for that group would likely pay for itself.
2. **Treat overtime as an early-warning flag.** It splits leavers from stayers more cleanly than almost anything else, so tracking who's consistently over hours gives managers a checklist before people reach the door.
3. **Protect the lower pay bands.** Low income paired with a junior role is where retention spending goes furthest — those people are both the most likely to leave and the most movable by a modest intervention.

---

## What's in this repo

| File | What it is |
|---|---|
| `HR_Attrition_Analysis_EDA.ipynb` | Python notebook — cleaning, correlations and profiling |
| `IBM_HR_Attrition_SQL.sql` | Nine business questions answered in SQL |
| `HR_Attrition_analysis_Dashboard.pbix` | The Power BI dashboard file |
| `HR_Dashboard.pdf` | A static export of the dashboard |
| `IBM_HR_Attrition_Report.docx` | Full written report with charts |
| `IBM_HR_Attrition_Presentation.pptx` | Slide-deck version of the project |
| `assets/` | Dashboard and chart images used in the report and README |

---

## How to reproduce

**1. Python — clean and explore**
```bash
pip install pandas numpy seaborn matplotlib sqlalchemy pymysql
jupyter notebook HR_Attrition_Analysis_EDA.ipynb
```
The notebook drops constant and identifier columns, standardises column names to `snake_case`, checks correlations, profiles who leaves, and writes out a cleaned CSV.

**2. SQL — question the data**
Load the cleaned table into MySQL, then run the queries in `IBM_HR_Attrition_SQL.sql`. They cover the overall rate, breakdowns by department, role, demographics and compensation, and the highest-risk factor combinations (using `CASE` banding and window functions for ranking).

**3. Power BI — communicate**
Open `HR_Attrition_analysis_Dashboard.pbix` in Power BI Desktop to explore the interactive version, or view `HR_Dashboard.pdf` for a static snapshot.

---

## Tech stack

`Python (pandas · NumPy · seaborn)` · `SQL (MySQL)` · `Power BI` · `Jupyter`

---

## Limitations & next steps

This is a fictional, point-in-time dataset, so it shows strong associations but can't prove causation, and it describes the past rather than forecasting the future. The natural next steps:

- Build a **classification model** (logistic regression or a gradient-boosted tree) to score each employee's attrition risk and confirm which factors carry weight once the others are held constant.
- Bring in **time-based data** so the analysis moves from "who left" to "who's about to."
- **Validate** the overtime and Sales findings against real exit-interview notes.

---

*Built by **Venkata Modem** as a data analytics portfolio project. Feedback and questions are welcome.*
