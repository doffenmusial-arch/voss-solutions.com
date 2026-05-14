<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Voss — Revenue-First Web Design</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500;600&family=Playfair+Display:ital,wght@1,400&display=swap" rel="stylesheet">
<style>
  *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

  :root {
    --navy: #0A1628;
    --navy-mid: #152238;
    --navy-light: #1E3050;
    --gold: #C9A84C;
    --gold-light: #E8D5A3;
    --cream: #FAFAF8;
    --warm-white: #FFFFFF;
    --gray-light: #F4F3F0;
    --gray-mid: #C8C5BE;
    --gray-text: #6B6760;
    --text-dark: #0A1628;
    --text-body: #2C2C2A;
  }

  html { scroll-behavior: smooth; }

  body {
    font-family: 'DM Sans', sans-serif;
    background: var(--cream);
    color: var(--text-body);
    overflow-x: hidden;
    cursor: none;
  }

  /* Custom cursor */
  .cursor {
    width: 10px;
    height: 10px;
    background: var(--gold);
    border-radius: 50%;
    position: fixed;
    top: 0; left: 0;
    pointer-events: none;
    z-index: 9999;
    transform: translate(-50%, -50%);
    transition: transform 0.1s ease, width 0.25s ease, height 0.25s ease, background 0.25s ease;
  }
  .cursor-ring {
    width: 36px;
    height: 36px;
    border: 1.5px solid var(--navy);
    border-radius: 50%;
    position: fixed;
    top: 0; left: 0;
    pointer-events: none;
    z-index: 9998;
    transform: translate(-50%, -50%);
    transition: transform 0.18s ease, width 0.25s ease, height 0.25s ease, opacity 0.25s ease;
    opacity: 0.4;
  }
  body:hover .cursor { opacity: 1; }

  /* Nav */
  nav {
    position: fixed;
    top: 0; left: 0; right: 0;
    z-index: 100;
    padding: 24px 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    transition: background 0.4s ease, padding 0.4s ease, box-shadow 0.4s ease;
  }
  nav.scrolled {
    background: rgba(250, 250, 248, 0.96);
    backdrop-filter: blur(12px);
    padding: 16px 60px;
    box-shadow: 0 1px 0 rgba(10,22,40,0.08);
  }
  .nav-logo {
    font-family: 'DM Serif Display', serif;
    font-size: 22px;
    color: var(--navy);
    letter-spacing: 0.08em;
    text-decoration: none;
  }
  .nav-links { display: flex; gap: 40px; list-style: none; align-items: center; }
  .nav-links a {
    text-decoration: none;
    color: var(--navy);
    font-size: 14px;
    font-weight: 400;
    letter-spacing: 0.02em;
    opacity: 0.7;
    transition: opacity 0.2s;
  }
  .nav-links a:hover { opacity: 1; }
  .nav-cta {
    background: var(--navy);
    color: white !important;
    opacity: 1 !important;
    padding: 10px 22px;
    border-radius: 4px;
    font-weight: 500 !important;
    font-size: 14px;
    transition: background 0.2s ease !important;
  }
  .nav-cta:hover { background: var(--navy-mid) !important; }

  /* Hero */
  .hero {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 160px 60px 80px;
    position: relative;
    overflow: hidden;
  }

  .hero-bg-lines {
    position: absolute;
    inset: 0;
    pointer-events: none;
    overflow: hidden;
  }
  .hero-bg-lines::before {
    content: '';
    position: absolute;
    width: 600px;
    height: 600px;
    border-radius: 50%;
    border: 1px solid rgba(201,168,76,0.12);
    top: -100px;
    right: -100px;
    animation: rotateSlow 40s linear infinite;
  }
  .hero-bg-lines::after {
    content: '';
    position: absolute;
    width: 900px;
    height: 900px;
    border-radius: 50%;
    border: 1px solid rgba(10,22,40,0.05);
    top: -250px;
    right: -250px;
    animation: rotateSlow 60s linear infinite reverse;
  }

  @keyframes rotateSlow {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
  }

  .hero-tag {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-size: 12px;
    font-weight: 500;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 32px;
    opacity: 0;
    transform: translateY(20px);
    animation: fadeUp 0.8s ease 0.2s forwards;
  }
  .hero-tag::before {
    content: '';
    display: block;
    width: 28px;
    height: 1px;
    background: var(--gold);
  }

  .hero-h1 {
    font-family: 'DM Serif Display', serif;
    font-size: clamp(48px, 6vw, 84px);
    line-height: 1.06;
    color: var(--navy);
    max-width: 780px;
    opacity: 0;
    transform: translateY(30px);
    animation: fadeUp 0.9s ease 0.4s forwards;
    letter-spacing: -0.01em;
  }
  .hero-h1 em {
    font-style: italic;
    color: var(--gold);
  }

  .hero-sub {
    margin-top: 28px;
    font-size: 18px;
    line-height: 1.65;
    color: var(--gray-text);
    max-width: 520px;
    font-weight: 300;
    opacity: 0;
    transform: translateY(20px);
    animation: fadeUp 0.9s ease 0.6s forwards;
  }

  .hero-actions {
    margin-top: 44px;
    display: flex;
    gap: 16px;
    align-items: center;
    opacity: 0;
    transform: translateY(20px);
    animation: fadeUp 0.9s ease 0.8s forwards;
  }

  .btn-primary {
    background: var(--navy);
    color: white;
    padding: 16px 32px;
    font-size: 15px;
    font-weight: 500;
    border-radius: 4px;
    text-decoration: none;
    display: inline-block;
    transition: background 0.2s ease, transform 0.2s ease;
    letter-spacing: 0.01em;
  }
  .btn-primary:hover { background: var(--navy-mid); transform: translateY(-1px); }

  .btn-ghost {
    color: var(--navy);
    font-size: 15px;
    font-weight: 400;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    opacity: 0.65;
    transition: opacity 0.2s, gap 0.2s;
  }
  .btn-ghost:hover { opacity: 1; gap: 12px; }
  .btn-ghost .arrow { font-size: 18px; }

  .hero-metrics {
    margin-top: 80px;
    display: flex;
    gap: 60px;
    opacity: 0;
    animation: fadeUp 0.9s ease 1s forwards;
    padding-top: 40px;
    border-top: 1px solid rgba(10,22,40,0.08);
    max-width: 600px;
  }
  .metric-item {}
  .metric-num {
    font-family: 'DM Serif Display', serif;
    font-size: 36px;
    color: var(--navy);
    line-height: 1;
  }
  .metric-label {
    font-size: 13px;
    color: var(--gray-text);
    margin-top: 4px;
    font-weight: 400;
  }

  .hero-scroll-indicator {
    position: absolute;
    bottom: 40px;
    left: 60px;
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 12px;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    color: var(--gray-text);
    opacity: 0;
    animation: fadeUp 1s ease 1.2s forwards;
  }
  .scroll-line {
    width: 40px;
    height: 1px;
    background: var(--gray-mid);
    position: relative;
    overflow: hidden;
  }
  .scroll-line::after {
    content: '';
    position: absolute;
    inset: 0;
    background: var(--navy);
    animation: lineSlide 2s ease-in-out infinite;
  }
  @keyframes lineSlide {
    0% { transform: translateX(-100%); }
    50% { transform: translateX(0); }
    100% { transform: translateX(100%); }
  }

  @keyframes fadeUp {
    to { opacity: 1; transform: translateY(0); }
  }

  /* Section base */
  section { padding: 100px 60px; }

  .section-tag {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-size: 11px;
    font-weight: 500;
    letter-spacing: 0.14em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 20px;
  }
  .section-tag::before {
    content: '';
    display: block;
    width: 20px;
    height: 1px;
    background: var(--gold);
  }

  .section-h2 {
    font-family: 'DM Serif Display', serif;
    font-size: clamp(34px, 4vw, 52px);
    color: var(--navy);
    line-height: 1.1;
    letter-spacing: -0.01em;
  }
  .section-h2 em { font-style: italic; color: var(--gold); }

  .section-body {
    font-size: 17px;
    line-height: 1.7;
    color: var(--gray-text);
    font-weight: 300;
    max-width: 560px;
    margin-top: 16px;
  }

  /* Problem section */
  .problem {
    background: var(--navy);
    color: white;
    padding: 100px 60px;
  }
  .problem .section-h2 { color: white; }
  .problem .section-body { color: rgba(255,255,255,0.55); }
  .problem .section-tag { color: var(--gold-light); }
  .problem .section-tag::before { background: var(--gold-light); }

  .problem-grid {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    gap: 2px;
    margin-top: 60px;
  }
  .problem-card {
    background: var(--navy-light);
    padding: 40px 36px;
    position: relative;
    overflow: hidden;
    transition: background 0.3s ease;
  }
  .problem-card:hover { background: var(--navy-mid); }
  .problem-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0;
    width: 2px;
    height: 0;
    background: var(--gold);
    transition: height 0.4s ease;
  }
  .problem-card:hover::before { height: 100%; }

  .problem-num {
    font-family: 'DM Serif Display', serif;
    font-size: 48px;
    color: rgba(255,255,255,0.08);
    position: absolute;
    top: 20px;
    right: 28px;
    line-height: 1;
  }
  .problem-title {
    font-size: 18px;
    font-weight: 500;
    color: white;
    margin-bottom: 12px;
    line-height: 1.3;
  }
  .problem-text {
    font-size: 14px;
    line-height: 1.7;
    color: rgba(255,255,255,0.45);
  }

  /* How it works */
  .how {
    background: var(--cream);
  }
  .how-inner {
    max-width: 1100px;
    margin: 0 auto;
  }
  .how-header {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 60px;
    align-items: end;
    margin-bottom: 80px;
  }
  .how-steps {
    display: flex;
    flex-direction: column;
    gap: 0;
  }
  .how-step {
    display: grid;
    grid-template-columns: 80px 1fr;
    gap: 32px;
    padding: 36px 0;
    border-bottom: 1px solid rgba(10,22,40,0.07);
    position: relative;
    cursor: default;
    transition: padding 0.3s ease;
  }
  .how-step:hover { padding: 36px 0 36px 12px; }
  .how-step-num {
    font-family: 'DM Serif Display', serif;
    font-size: 13px;
    color: var(--gold);
    letter-spacing: 0.1em;
    padding-top: 4px;
    font-style: italic;
  }
  .how-step-content {}
  .how-step-title {
    font-size: 20px;
    font-weight: 500;
    color: var(--navy);
    margin-bottom: 8px;
  }
  .how-step-text {
    font-size: 15px;
    line-height: 1.65;
    color: var(--gray-text);
  }

  /* Services */
  .services {
    background: var(--gray-light);
  }
  .services-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    margin-top: 60px;
  }
  .service-card {
    background: white;
    padding: 40px 36px;
    border-radius: 6px;
    border: 1px solid rgba(10,22,40,0.06);
    position: relative;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }
  .service-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 20px 60px rgba(10,22,40,0.08);
  }
  .service-icon {
    width: 44px;
    height: 44px;
    background: var(--navy);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 28px;
  }
  .service-icon svg { width: 22px; height: 22px; stroke: white; fill: none; stroke-width: 1.5; stroke-linecap: round; stroke-linejoin: round; }

  .service-title {
    font-size: 19px;
    font-weight: 500;
    color: var(--navy);
    margin-bottom: 12px;
  }
  .service-text {
    font-size: 14px;
    line-height: 1.7;
    color: var(--gray-text);
    margin-bottom: 24px;
  }
  .service-price {
    font-family: 'DM Serif Display', serif;
    font-size: 26px;
    color: var(--navy);
  }
  .service-price span {
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    color: var(--gray-text);
    font-weight: 400;
  }
  .service-tag {
    position: absolute;
    top: 20px;
    right: 20px;
    background: var(--gold-light);
    color: #8B6914;
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    padding: 4px 10px;
    border-radius: 2px;
  }

  /* Results */
  .results {
    background: var(--cream);
    overflow: hidden;
  }
  .results-inner {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 80px;
    align-items: center;
  }
  .results-visual {
    background: var(--navy);
    border-radius: 8px;
    padding: 48px 40px;
    position: relative;
    overflow: hidden;
  }
  .results-visual::before {
    content: '';
    position: absolute;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    border: 1px solid rgba(201,168,76,0.2);
    bottom: -100px;
    right: -100px;
  }
  .result-stat {
    margin-bottom: 36px;
  }
  .result-stat-num {
    font-family: 'DM Serif Display', serif;
    font-size: 52px;
    color: white;
    line-height: 1;
    position: relative;
    display: inline-block;
  }
  .result-stat-num .gold { color: var(--gold); }
  .result-stat-label {
    font-size: 14px;
    color: rgba(255,255,255,0.45);
    margin-top: 6px;
  }
  .result-bar {
    height: 3px;
    background: rgba(255,255,255,0.1);
    border-radius: 2px;
    margin-top: 8px;
    overflow: hidden;
  }
  .result-bar-fill {
    height: 100%;
    background: var(--gold);
    border-radius: 2px;
    width: 0;
    transition: width 1.2s ease;
  }

  .testimonial-card {
    background: white;
    border-radius: 6px;
    padding: 32px;
    border: 1px solid rgba(10,22,40,0.07);
    margin-top: 32px;
    position: relative;
  }
  .testimonial-card::before {
    content: '"';
    font-family: 'DM Serif Display', serif;
    font-size: 72px;
    color: var(--gold-light);
    position: absolute;
    top: -10px;
    left: 24px;
    line-height: 1;
  }
  .testimonial-text {
    font-size: 16px;
    line-height: 1.65;
    color: var(--text-body);
    padding-top: 16px;
  }
  .testimonial-author {
    margin-top: 20px;
    display: flex;
    align-items: center;
    gap: 12px;
  }
  .testimonial-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: var(--navy);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 13px;
    font-weight: 500;
  }
  .testimonial-name {
    font-size: 14px;
    font-weight: 500;
    color: var(--navy);
  }
  .testimonial-role {
    font-size: 12px;
    color: var(--gray-text);
  }

  /* Trust bar */
  .trust-bar {
    background: var(--navy);
    padding: 28px 60px;
    display: flex;
    align-items: center;
    gap: 48px;
    overflow: hidden;
  }
  .trust-label {
    font-size: 11px;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: rgba(255,255,255,0.3);
    white-space: nowrap;
    flex-shrink: 0;
  }
  .trust-divider {
    width: 1px;
    height: 24px;
    background: rgba(255,255,255,0.1);
    flex-shrink: 0;
  }
  .trust-logos {
    display: flex;
    gap: 40px;
    align-items: center;
    animation: scrollTrust 20s linear infinite;
  }
  .trust-logo {
    font-size: 13px;
    font-weight: 500;
    color: rgba(255,255,255,0.25);
    letter-spacing: 0.05em;
    white-space: nowrap;
    transition: color 0.3s;
  }
  .trust-logo:hover { color: rgba(255,255,255,0.6); }

  @keyframes scrollTrust {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
  }

  /* Guarantee */
  .guarantee {
    background: var(--gray-light);
    text-align: center;
  }
  .guarantee-badge {
    width: 90px;
    height: 90px;
    border: 2px solid var(--gold);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 32px;
    position: relative;
  }
  .guarantee-badge svg { width: 36px; height: 36px; stroke: var(--gold); fill: none; stroke-width: 1.5; stroke-linecap: round; stroke-linejoin: round; }
  .guarantee-badge::before {
    content: '';
    position: absolute;
    inset: -6px;
    border-radius: 50%;
    border: 1px solid rgba(201,168,76,0.25);
    animation: pulse 3s ease infinite;
  }
  @keyframes pulse {
    0%, 100% { transform: scale(1); opacity: 0.5; }
    50% { transform: scale(1.05); opacity: 1; }
  }
  .guarantee h2 {
    font-family: 'DM Serif Display', serif;
    font-size: clamp(32px, 4vw, 50px);
    color: var(--navy);
    max-width: 700px;
    margin: 0 auto 20px;
    line-height: 1.15;
  }
  .guarantee h2 em { font-style: italic; color: var(--gold); }
  .guarantee p {
    font-size: 17px;
    color: var(--gray-text);
    max-width: 540px;
    margin: 0 auto;
    line-height: 1.65;
    font-weight: 300;
  }
  .guarantee-fine {
    margin-top: 40px;
    font-size: 13px;
    color: var(--gray-mid);
  }

  /* CTA section */
  .cta-section {
    background: var(--navy);
    padding: 120px 60px;
    text-align: center;
    position: relative;
    overflow: hidden;
  }
  .cta-section::before {
    content: '';
    position: absolute;
    width: 500px;
    height: 500px;
    border-radius: 50%;
    border: 1px solid rgba(201,168,76,0.1);
    top: -150px;
    left: -150px;
  }
  .cta-section::after {
    content: '';
    position: absolute;
    width: 700px;
    height: 700px;
    border-radius: 50%;
    border: 1px solid rgba(201,168,76,0.06);
    bottom: -250px;
    right: -200px;
  }
  .cta-section h2 {
    font-family: 'DM Serif Display', serif;
    font-size: clamp(36px, 5vw, 60px);
    color: white;
    max-width: 680px;
    margin: 0 auto 20px;
    line-height: 1.1;
    position: relative;
    z-index: 1;
  }
  .cta-section h2 em { font-style: italic; color: var(--gold); }
  .cta-section p {
    color: rgba(255,255,255,0.5);
    font-size: 17px;
    max-width: 480px;
    margin: 0 auto 44px;
    line-height: 1.65;
    font-weight: 300;
    position: relative;
    z-index: 1;
  }
  .cta-section .btn-primary {
    background: var(--gold);
    color: var(--navy);
    font-weight: 600;
    position: relative;
    z-index: 1;
    transition: background 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
  }
  .cta-section .btn-primary:hover {
    background: #d9b860;
    transform: translateY(-2px);
    box-shadow: 0 12px 40px rgba(201,168,76,0.3);
  }

  /* Contact form */
  .contact {
    background: var(--cream);
  }
  .contact-inner {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 80px;
    max-width: 1000px;
  }
  .form-field {
    margin-bottom: 20px;
  }
  .form-field label {
    display: block;
    font-size: 13px;
    font-weight: 500;
    color: var(--navy);
    letter-spacing: 0.04em;
    margin-bottom: 8px;
  }
  .form-field input,
  .form-field textarea,
  .form-field select {
    width: 100%;
    padding: 14px 16px;
    border: 1px solid rgba(10,22,40,0.12);
    border-radius: 4px;
    font-size: 15px;
    font-family: 'DM Sans', sans-serif;
    color: var(--text-body);
    background: white;
    outline: none;
    transition: border-color 0.2s ease;
    appearance: none;
  }
  .form-field input:focus,
  .form-field textarea:focus,
  .form-field select:focus {
    border-color: var(--navy);
  }
  .form-field textarea { resize: vertical; min-height: 120px; }
  .form-submit {
    background: var(--navy);
    color: white;
    border: none;
    padding: 16px 36px;
    font-size: 15px;
    font-weight: 500;
    font-family: 'DM Sans', sans-serif;
    border-radius: 4px;
    cursor: pointer;
    width: 100%;
    transition: background 0.2s ease;
    letter-spacing: 0.01em;
  }
  .form-submit:hover { background: var(--navy-mid); }

  .contact-info { padding-top: 16px; }
  .contact-info-item {
    display: flex;
    gap: 16px;
    align-items: flex-start;
    margin-bottom: 32px;
    padding-bottom: 32px;
    border-bottom: 1px solid rgba(10,22,40,0.07);
  }
  .contact-info-item:last-child { border-bottom: none; }
  .contact-icon {
    width: 40px;
    height: 40px;
    background: var(--navy);
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .contact-icon svg { width: 18px; height: 18px; stroke: white; fill: none; stroke-width: 1.5; stroke-linecap: round; stroke-linejoin: round; }
  .contact-info-label {
    font-size: 12px;
    font-weight: 500;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 4px;
  }
  .contact-info-value {
    font-size: 16px;
    color: var(--navy);
    font-weight: 400;
  }

  /* Footer */
  footer {
    background: var(--navy);
    padding: 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .footer-logo {
    font-family: 'DM Serif Display', serif;
    font-size: 20px;
    color: white;
    letter-spacing: 0.08em;
  }
  .footer-copy {
    font-size: 13px;
    color: rgba(255,255,255,0.3);
  }
  .footer-links {
    display: flex;
    gap: 32px;
    list-style: none;
  }
  .footer-links a {
    text-decoration: none;
    font-size: 13px;
    color: rgba(255,255,255,0.35);
    transition: color 0.2s;
  }
  .footer-links a:hover { color: rgba(255,255,255,0.7); }

  /* Scroll reveal */
  .reveal {
    opacity: 0;
    transform: translateY(28px);
    transition: opacity 0.7s ease, transform 0.7s ease;
  }
  .reveal.visible {
    opacity: 1;
    transform: translateY(0);
  }
  .reveal-delay-1 { transition-delay: 0.1s; }
  .reveal-delay-2 { transition-delay: 0.2s; }
  .reveal-delay-3 { transition-delay: 0.3s; }
  .reveal-delay-4 { transition-delay: 0.4s; }
</style>
</head>
<body>

<!-- Custom cursor -->
<div class="cursor" id="cursor"></div>
<div class="cursor-ring" id="cursorRing"></div>

<!-- Nav -->
<nav id="navbar">
  <a href="#" class="nav-logo">VOSS</a>
  <ul class="nav-links">
    <li><a href="#how">Process</a></li>
    <li><a href="#services">Services</a></li>
    <li><a href="#results">Results</a></li>
    <li><a href="#contact" class="nav-cta">Get a Free Audit</a></li>
  </ul>
</nav>

<!-- Hero -->
<section class="hero">
  <div class="hero-bg-lines"></div>
  <div class="hero-tag">Revenue-First Web Design</div>
  <h1 class="hero-h1">Your website should be<br>your best <em>sales rep</em></h1>
  <p class="hero-sub">Voss builds websites that generate leads, not just impressions. Designed for local service businesses ready to grow.</p>
  <div class="hero-actions">
    <a href="#contact" class="btn-primary">Get Your Free Audit</a>
    <a href="#how" class="btn-ghost">See how it works <span class="arrow">&#8594;</span></a>
  </div>
  <div class="hero-metrics">
    <div class="metric-item">
      <div class="metric-num">47+</div>
      <div class="metric-label">Clients served</div>
    </div>
    <div class="metric-item">
      <div class="metric-num">3.8x</div>
      <div class="metric-label">Average lead increase</div>
    </div>
    <div class="metric-item">
      <div class="metric-num">60 days</div>
      <div class="metric-label">To first results</div>
    </div>
  </div>
  <div class="hero-scroll-indicator">
    <div class="scroll-line"></div>
    Scroll
  </div>
</section>

<!-- Trust bar -->
<div class="trust-bar">
  <span class="trust-label">Trusted by</span>
  <div class="trust-divider"></div>
  <div class="trust-logos" id="trustLogos">
    <span class="trust-logo">Lumina Medspa</span>
    <span class="trust-logo">Apex Aesthetics</span>
    <span class="trust-logo">Revive Clinic Oslo</span>
    <span class="trust-logo">Nordic Glow</span>
    <span class="trust-logo">Pure Form Studio</span>
    <span class="trust-logo">Solace Skin</span>
    <span class="trust-logo">Lumina Medspa</span>
    <span class="trust-logo">Apex Aesthetics</span>
    <span class="trust-logo">Revive Clinic Oslo</span>
    <span class="trust-logo">Nordic Glow</span>
    <span class="trust-logo">Pure Form Studio</span>
    <span class="trust-logo">Solace Skin</span>
  </div>
</div>

<!-- Problem section -->
<section class="problem">
  <div class="section-tag">The Real Problem</div>
  <h2 class="section-h2" style="max-width:600px;">Most business websites are<br><em>digital brochures</em></h2>
  <p class="section-body">They look fine. They do nothing. Your competitors are winning clients online because they treat their website as a revenue system.</p>

  <div class="problem-grid">
    <div class="problem-card reveal">
      <div class="problem-num">01</div>
      <div class="problem-title">No clear call to action</div>
      <div class="problem-text">Visitors land, read, leave. No urgency, no next step, no conversion. Traffic without strategy is just vanity.</div>
    </div>
    <div class="problem-card reveal reveal-delay-1">
      <div class="problem-num">02</div>
      <div class="problem-title">Built for aesthetics, not outcomes</div>
      <div class="problem-text">Beautiful design means nothing if it does not move people toward booking, calling, or buying.</div>
    </div>
    <div class="problem-card reveal reveal-delay-2">
      <div class="problem-num">03</div>
      <div class="problem-title">Invisible on Google</div>
      <div class="problem-text">A site that cannot be found is a site that cannot earn. Most agencies deliver the design and ignore the discoverability.</div>
    </div>
  </div>
</section>

<!-- How it works -->
<section class="how" id="how">
  <div class="how-inner">
    <div class="how-header">
      <div>
        <div class="section-tag reveal">Our Process</div>
        <h2 class="section-h2 reveal reveal-delay-1">A system built to<br><em>convert</em></h2>
      </div>
      <p class="section-body reveal reveal-delay-2">We do not just hand you a website. We build and manage your entire client acquisition system from day one.</p>
    </div>
    <div class="how-steps">
      <div class="how-step reveal">
        <div class="how-step-num">Step 01</div>
        <div class="how-step-content">
          <div class="how-step-title">Free website and visibility audit</div>
          <div class="how-step-text">We analyze your current site, your competitors, and your local Google presence. You get a full report showing exactly where leads are being lost. No charge, no obligation.</div>
        </div>
      </div>
      <div class="how-step reveal reveal-delay-1">
        <div class="how-step-num">Step 02</div>
        <div class="how-step-content">
          <div class="how-step-title">Strategy and design sprint</div>
          <div class="how-step-text">We map out a conversion architecture before we design a single page. Copy, structure, and flow are built around one goal: turning visitors into clients.</div>
        </div>
      </div>
      <div class="how-step reveal reveal-delay-2">
        <div class="how-step-num">Step 03</div>
        <div class="how-step-content">
          <div class="how-step-title">Launch, test, and optimize</div>
          <div class="how-step-text">We launch your site with tracking in place, then A/B test and refine based on real user behavior. This is where most agencies stop. For us, it is where the work starts.</div>
        </div>
      </div>
      <div class="how-step reveal reveal-delay-3">
        <div class="how-step-num">Step 04</div>
        <div class="how-step-content">
          <div class="how-step-title">Traffic and lead generation</div>
          <div class="how-step-text">Once the foundation converts, we add fuel with Google Ads and local SEO. You now have a system: targeted traffic flowing into a site built to close.</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Services -->
<section class="services" id="services">
  <div class="section-tag reveal">What We Offer</div>
  <h2 class="section-h2 reveal reveal-delay-1" style="margin-bottom:0;">Everything you need,<br>nothing you <em>do not</em></h2>
  <div class="services-grid">

    <div class="service-card reveal">
      <div class="service-icon">
        <svg viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/></svg>
      </div>
      <div class="service-title">Revenue Website</div>
      <div class="service-text">Full design and build. Conversion copy, fast loading, mobile-first, Google Analytics and heatmaps installed. Yours to own outright.</div>
      <div class="service-price">From 2 500 USD <span>one-time</span></div>
    </div>

    <div class="service-card reveal reveal-delay-1">
      <div class="service-tag">Most Popular</div>
      <div class="service-icon">
        <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 8v4l3 3"/></svg>
      </div>
      <div class="service-title">Growth Retainer</div>
      <div class="service-text">Monthly Google Ads management, local SEO, review generation, and a monthly performance report. One partner for all your growth.</div>
      <div class="service-price">From 800 USD <span>/month</span></div>
    </div>

    <div class="service-card reveal reveal-delay-2">
      <div class="service-icon">
        <svg viewBox="0 0 24 24"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
      </div>
      <div class="service-title">Care Plan</div>
      <div class="service-text">Hosting, security updates, backups, and priority support. Your site stays fast, secure, and online without you thinking about it.</div>
      <div class="service-price">From 199 USD <span>/month</span></div>
    </div>

    <div class="service-card reveal">
      <div class="service-icon">
        <svg viewBox="0 0 24 24"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
      </div>
      <div class="service-title">Google Ads Setup</div>
      <div class="service-text">Full campaign architecture, keyword research, ad copy, and conversion tracking. Paid traffic done right from the first click.</div>
      <div class="service-price">From 500 USD <span>one-time</span></div>
    </div>

    <div class="service-card reveal reveal-delay-1">
      <div class="service-icon">
        <svg viewBox="0 0 24 24"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
      </div>
      <div class="service-title">Email Automations</div>
      <div class="service-text">Lead capture flows, follow-up sequences, and booking confirmations that run without you lifting a finger.</div>
      <div class="service-price">From 500 USD <span>one-time</span></div>
    </div>

    <div class="service-card reveal reveal-delay-2">
      <div class="service-icon">
        <svg viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
      </div>
      <div class="service-title">Reputation Management</div>
      <div class="service-text">Automated review requests, response templates, and a strategy to build your online authority month over month.</div>
      <div class="service-price">From 250 USD <span>/month</span></div>
    </div>

  </div>
</section>

<!-- Results -->
<section class="results" id="results">
  <div class="results-inner">
    <div>
      <div class="section-tag reveal">Proven Results</div>
      <h2 class="section-h2 reveal reveal-delay-1">Numbers that<br>matter to <em>your</em> business</h2>
      <p class="section-body reveal reveal-delay-2">We measure success by one thing: how many more clients you are getting. Not impressions. Not traffic. Clients.</p>

      <div class="testimonial-card reveal reveal-delay-3">
        <p class="testimonial-text">Voss redesigned our site in three weeks. Within 45 days we had more incoming inquiries than the previous four months combined. The Google Ads they run now pay for themselves every week.</p>
        <div class="testimonial-author">
          <div class="testimonial-avatar">KR</div>
          <div>
            <div class="testimonial-name">Karin Rosenberg</div>
            <div class="testimonial-role">Owner, Lumina Medspa</div>
          </div>
        </div>
      </div>
    </div>

    <div class="results-visual reveal reveal-delay-1">
      <div class="result-stat">
        <div class="result-stat-num"><span class="gold" id="counter1">0</span>%</div>
        <div class="result-stat-label">Average increase in qualified leads after 90 days</div>
        <div class="result-bar"><div class="result-bar-fill" id="bar1" style="width:0%"></div></div>
      </div>
      <div class="result-stat">
        <div class="result-stat-num"><span id="counter2">0</span> days</div>
        <div class="result-stat-label">Average time to first measurable results</div>
        <div class="result-bar"><div class="result-bar-fill" id="bar2" style="width:0%"></div></div>
      </div>
      <div class="result-stat" style="margin-bottom:0">
        <div class="result-stat-num"><span class="gold" id="counter3">0</span>x</div>
        <div class="result-stat-label">Average return on website investment within 6 months</div>
        <div class="result-bar"><div class="result-bar-fill" id="bar3" style="width:0%"></div></div>
      </div>
    </div>
  </div>
</section>

<!-- Guarantee -->
<section class="guarantee">
  <div class="guarantee-badge reveal">
    <svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
  </div>
  <h2 class="reveal reveal-delay-1">If you do not get results,<br>we work for <em>free</em></h2>
  <p class="reveal reveal-delay-2">Every website we build comes with a 60-day performance guarantee. If your new site does not generate at least five qualified leads in the first 60 days, we keep working at no charge until it does.</p>
  <p class="guarantee-fine reveal reveal-delay-3">Terms apply. Only available when paired with our Growth Retainer or Google Ads service.</p>
</section>

<!-- CTA -->
<section class="cta-section">
  <h2>Ready to turn your website<br>into a <em>revenue engine?</em></h2>
  <p>Book a free audit today. We will show you exactly what is costing you leads and what it would take to fix it.</p>
  <a href="#contact" class="btn-primary">Get My Free Audit</a>
</section>

<!-- Contact -->
<section class="contact" id="contact">
  <div class="contact-inner">
    <div>
      <div class="section-tag reveal">Get in Touch</div>
      <h2 class="section-h2 reveal reveal-delay-1" style="margin-bottom:24px;">Start with a<br>free audit</h2>
      <form onsubmit="handleSubmit(event)">
        <div class="form-field reveal reveal-delay-2">
          <label>Your name</label>
          <input type="text" placeholder="Maria Hansen" required>
        </div>
        <div class="form-field reveal reveal-delay-2">
          <label>Business email</label>
          <input type="email" placeholder="maria@yourbusiness.com" required>
        </div>
        <div class="form-field reveal reveal-delay-3">
          <label>Business type</label>
          <select>
            <option>Medspa / Aesthetics Clinic</option>
            <option>Dental Practice</option>
            <option>Fitness / Wellness Studio</option>
            <option>Legal or Financial Services</option>
            <option>Other Local Service Business</option>
          </select>
        </div>
        <div class="form-field reveal reveal-delay-3">
          <label>What is your biggest challenge right now?</label>
          <textarea placeholder="We are getting traffic but no inquiries..."></textarea>
        </div>
        <button type="submit" class="form-submit reveal reveal-delay-4">Send My Audit Request</button>
      </form>
    </div>

    <div class="contact-info">
      <div class="contact-info-item reveal reveal-delay-1">
        <div class="contact-icon">
          <svg viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
        </div>
        <div>
          <div class="contact-info-label">Email</div>
          <div class="contact-info-value">hello@voss.agency</div>
        </div>
      </div>
      <div class="contact-info-item reveal reveal-delay-2">
        <div class="contact-icon">
          <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div>
          <div class="contact-info-label">Response time</div>
          <div class="contact-info-value">Within 24 hours, always</div>
        </div>
      </div>
      <div class="contact-info-item reveal reveal-delay-3">
        <div class="contact-icon">
          <svg viewBox="0 0 24 24"><path d="M12 22s-8-4.5-8-11.8A8 8 0 0 1 12 2a8 8 0 0 1 8 8.2c0 7.3-8 11.8-8 11.8z"/><circle cx="12" cy="10" r="3"/></svg>
        </div>
        <div>
          <div class="contact-info-label">Based in</div>
          <div class="contact-info-value">Scandinavia, serving globally</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer>
  <span class="footer-logo">VOSS</span>
  <span class="footer-copy">&copy; 2025 Voss. All rights reserved.</span>
  <ul class="footer-links">
    <li><a href="#">Privacy</a></li>
    <li><a href="#">Terms</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</footer>

<script>
  // Cursor
  const cursor = document.getElementById('cursor');
  const ring = document.getElementById('cursorRing');
  let mx = 0, my = 0, rx = 0, ry = 0;
  document.addEventListener('mousemove', e => { mx = e.clientX; my = e.clientY; cursor.style.left = mx+'px'; cursor.style.top = my+'px'; });
  function animRing() { rx += (mx-rx)*0.12; ry += (my-ry)*0.12; ring.style.left = rx+'px'; ring.style.top = ry+'px'; requestAnimationFrame(animRing); }
  animRing();
  document.querySelectorAll('a, button, .service-card, .problem-card, .how-step').forEach(el => {
    el.addEventListener('mouseenter', () => { cursor.style.width='16px'; cursor.style.height='16px'; ring.style.width='52px'; ring.style.height='52px'; ring.style.opacity='0.2'; });
    el.addEventListener('mouseleave', () => { cursor.style.width='10px'; cursor.style.height='10px'; ring.style.width='36px'; ring.style.height='36px'; ring.style.opacity='0.4'; });
  });

  // Nav scroll
  const navbar = document.getElementById('navbar');
  window.addEventListener('scroll', () => { navbar.classList.toggle('scrolled', window.scrollY > 40); });

  // Scroll reveal
  const revealEls = document.querySelectorAll('.reveal');
  const observer = new IntersectionObserver(entries => {
    entries.forEach(e => { if(e.isIntersecting) { e.target.classList.add('visible'); observer.unobserve(e.target); } });
  }, { threshold: 0.12 });
  revealEls.forEach(el => observer.observe(el));

  // Counters
  function animCount(el, target, duration, suffix='') {
    let start = null;
    function step(ts) {
      if(!start) start = ts;
      const pct = Math.min((ts-start)/duration, 1);
      el.textContent = Math.round(pct * target);
      if(pct < 1) requestAnimationFrame(step);
      else el.textContent = target;
    }
    requestAnimationFrame(step);
  }

  const resultsSection = document.querySelector('.results-visual');
  let counted = false;
  const cObs = new IntersectionObserver(entries => {
    if(entries[0].isIntersecting && !counted) {
      counted = true;
      animCount(document.getElementById('counter1'), 280, 1600);
      animCount(document.getElementById('counter2'), 38, 1200);
      animCount(document.getElementById('counter3'), 6, 1400);
      setTimeout(() => { document.getElementById('bar1').style.width = '85%'; }, 200);
      setTimeout(() => { document.getElementById('bar2').style.width = '60%'; }, 400);
      setTimeout(() => { document.getElementById('bar3').style.width = '75%'; }, 600);
    }
  }, { threshold: 0.3 });
  cObs.observe(resultsSection);

  // Form
  function handleSubmit(e) {
    e.preventDefault();
    const btn = e.target.querySelector('.form-submit');
    btn.textContent = 'Sent! We will be in touch within 24 hours.';
    btn.style.background = '#1E3050';
    btn.disabled = true;
  }
</script>
</body>
</html>
