# E-Commerce Funnel Performance Dashboard

---
Data Can Be Found At: https://mavenanalytics.io/data-playground/toy-store-e-commerce-database
---

## Overview

This analysis evaluates Maven Fuzzy Factory’s e-commerce purchase funnel, focusing on conversion efficiency, landing page performance, and how both evolved over time.

The central business question is straightforward: **where is the site losing customers before purchase, and which changes would have the greatest impact on conversion and revenue efficiency?**

The results point to two distinct performance stories:

- **site efficiency improved materially over time**, with both conversion rate and revenue per session trending upward
- **traffic volume weakened sharply in early 2015**, limiting order growth despite stronger conversion performance

Within the funnel, the clearest constraint sits in the middle of the journey at **Product Detail → Cart**, where users show interest but fail to move into purchase behavior at a strong enough rate.

Landing page performance is also highly uneven. **/lander-5** consistently outperformed the rest of the landing page mix, while **/lander-3** lagged throughout the period, pointing to a meaningful opportunity to improve performance before visitors ever reach product pages.

---

## Dashboard Preview

<img width="1903" height="1077" alt="image" src="https://github.com/user-attachments/assets/dd374730-6340-4548-8d82-166771e06e96" />

## Business Objectives

- Measure overall website performance using sessions, orders, conversion rate, revenue, and revenue per session
- Understand how users progress through the purchase funnel over time
- Identify which funnel steps create the most friction
- Evaluate which landing pages drive stronger or weaker downstream conversion
- Translate funnel findings into actions that improve conversion efficiency and revenue performance

---

## Key Business Questions

1. How is the website performing overall in terms of traffic, orders, and revenue efficiency?
2. Which stages of the funnel are converting efficiently, and which are constraining performance?
3. Is funnel performance improving over time?
4. Which landing pages are helping drive stronger conversion outcomes?
5. Where should optimization efforts focus first?

---

## Core Metrics

- **Total Sessions**
- **Total Orders**
- **Conversion Rate**
- **Total Revenue**
- **Revenue per Session**
- **Average Order Value**
- **Landing Page Conversion Rate**
- **Step-to-Step Funnel Conversion Rate**

---

## Executive Summary

Maven Fuzzy Factory generated **472.9K sessions**, **32.3K orders**, and **$1.94M in revenue**, at an overall **6.83% conversion rate** and **$4.10 revenue per session**.

Performance quality improved substantially over time. Monthly conversion rate increased from **3.19% in March 2012** to **8.31% in March 2015**, while revenue per session rose from **$1.60** to **$5.23**. Peak monthly efficiency occurred in **February 2015**, when conversion rate reached **8.69%** and revenue per session peaked at **$5.43**.

That efficiency gain was offset by a sharp decline in traffic in early 2015. Sessions fell from **29.7K in December 2014** to **15.1K in March 2015**, and orders dropped from **2,314** to **1,254** over the same period.

From a funnel perspective, the main loss point remained **Product Detail → Cart**. Later checkout stages held up comparatively well, which places the biggest opportunity earlier in the journey, before product interest becomes purchase intent.

Landing page performance was similarly uneven. **/lander-5** was the strongest performer, while **/lander-3** remained materially weaker than the rest of the landing page mix.

---

## Headline Results

- **Total Sessions:** 472,871
- **Total Orders:** 32,313
- **Conversion Rate:** 6.83%
- **Total Revenue:** $1,938,509.75
- **Revenue per Session:** $4.10
- **Average Order Value:** $59.99

### Supporting Trend Metrics

- **Monthly Conversion Rate:** 3.19% → 8.31% from Mar 2012 to Mar 2015
- **Monthly Revenue per Session:** $1.60 → $5.23 from Mar 2012 to Mar 2015
- **Peak Monthly Conversion Rate:** 8.69% in Feb 2015
- **Peak Monthly Revenue per Session:** $5.43 in Feb 2015
- **Peak Monthly Sessions:** 29,722 in Dec 2014
- **Peak Monthly Orders:** 2,314 in Dec 2014

---

## Funnel Findings

### Overall Funnel Shape

The purchase funnel narrowed significantly from session to order, with the largest meaningful constraint occurring in the middle of the journey rather than at the end of checkout.

Key step conversion rates:

- **Sessions → Products:** 55.24%
- **Products → Product Detail:** 80.47%
- **Product Detail → Cart:** 45.17%
- **Cart → Shipping:** 67.91%
- **Shipping → Billing:** 80.73%
- **Billing → Orders:** 62.07%

### Interpretation

Not every step is expected to convert at the same rate. Later stages usually reflect more qualified purchase intent, and some narrowing is natural throughout the funnel.

The weakness in **Product Detail → Cart** stands out because it remains constrained relative to the surrounding steps and relative to what a healthier purchase path would typically support. Users are reaching product pages, but too many are failing to move into cart behavior.

That points to likely friction in:
- product page clarity
- offer strength
- add-to-cart CTA effectiveness
- merchandising and persuasive design

By contrast, later-stage steps such as **Shipping → Billing** and **Billing → Orders** performed relatively well, which shifts the optimization focus away from checkout completion and toward mid-funnel decision-making.

---

## Trend Findings

### Conversion Efficiency Improved Substantially Over Time

Both **conversion rate** and **revenue per session** increased steadily across the analysis period.

This trend matters because it shows that the site became better at converting and monetizing traffic, rather than relying on traffic growth alone. Efficiency improved even before looking at total visit volume.

### Traffic Weakened Sharply in Early 2015

Despite stronger conversion performance, both sessions and orders dropped sharply in early 2015.

- **Sessions:** 29.7K in Dec 2014 → 15.1K in Mar 2015
- **Orders:** 2,314 in Dec 2014 → 1,254 in Mar 2015

That shift points to an acquisition-side problem rather than a broad deterioration in site conversion quality. By the end of the period, the site was more efficient than before, but it was operating on reduced traffic.

---

## Landing Page Findings

Landing page performance differed meaningfully across the major entry experiences.

### Highest-Performing Page
- **/lander-5** delivered the strongest conversion performance and finished clearly above the rest of the group

### Mid-Tier Pages
- **/home**
- **/lander-4**
- **/lander-2**

These pages performed materially better than the weakest alternatives, but did not match the top-end results of `/lander-5`.

### Lowest-Performing Pages
- **/lander-3**
- **/lander-1**

`/lander-3` remained the weakest major landing page throughout the period and consistently converted at a much lower rate than the top-performing pages.

### Aggregate Landing Page Performance

- **/lander-5:** 10.17% conversion rate, **$6.43** revenue per session
- **/lander-2:** 7.72% conversion rate, **$4.53** revenue per session
- **/home:** 7.06% conversion rate, **$4.25** revenue per session
- **/lander-4:** 7.54% conversion rate, **$4.84** revenue per session
- **/lander-1:** 4.53% conversion rate, **$2.29** revenue per session
- **/lander-3:** 3.39% conversion rate, **$2.10** revenue per session

### Interpretation

The spread across landing pages is too large to treat as noise. Entry-page quality is shaping downstream funnel performance before visitors even reach product detail pages.

`/lander-5` operates in a different tier from `/lander-3`, which suggests differences in message match, offer framing, page structure, and CTA hierarchy are materially affecting visitor quality and purchase intent.

---

## Business Implications

### 1. Mid-Funnel Friction Is Suppressing Conversion

The clearest site-side opportunity is not simply increasing traffic to product pages, but increasing the share of product-page visitors who move into cart behavior.

### 2. Landing Page Strategy Is Influencing Funnel Quality

Not all traffic enters the funnel under the same conditions. Stronger landing pages are likely doing a better job of matching visitor intent and preparing users to continue deeper into the journey.

### 3. Efficiency Gains Alone Will Not Offset Traffic Losses

Improved conversion rate and revenue per session are encouraging, but the early-2015 traffic decline shows that traffic health and funnel health need to be managed separately.

---

## Recommendations

### Prioritize Product Detail → Cart Optimization

This is the clearest point of constrained performance in the purchase journey.

Recommended focus areas:
- strengthen product page value communication
- test more prominent and clearer add-to-cart calls to action
- improve product presentation and merchandising
- reduce hesitation points on product pages

### Use /lander-5 as the Benchmark for Landing Page Strategy

`/lander-5` should be treated as the reference point for stronger landing page performance.

Recommended actions:
- identify what `/lander-5` is doing differently in layout, message hierarchy, CTA placement, and offer framing
- apply those learnings to weaker landing experiences
- use it as the basis for future landing page tests

### Review or Replace /lander-3

`/lander-3` is not a neutral variation. It is consistently underperforming and is likely lowering the quality of traffic entering the funnel.

Recommended actions:
- review message-to-audience alignment
- assess whether the offer and framing match traffic intent
- test a redesigned replacement rather than continuing with the current version unchanged

### Investigate the Early-2015 Traffic Decline Separately

The site improved in efficiency over time, but acquisition volume weakened. That requires a separate line of analysis.

Recommended actions:
- review traffic source mix and campaign changes leading into early 2015
- identify whether traffic losses were concentrated in specific channels
- separate acquisition-volume issues from site-conversion issues in performance reporting

### Monitor Funnel-Step Conversion Monthly

Top-line conversion rate is useful, but it does not show where performance is changing.

Recommended actions:
- track step-to-step conversion monthly
- monitor whether Product Detail → Cart improves after page changes
- use funnel-step trends as an ongoing optimization KPI

---

## Tools Used

- **Python** for data loading, validation, and database preparation
- **PostgreSQL** for KPI, funnel, trend, and landing page analysis
- **Power BI** for dashboarding and stakeholder reporting
