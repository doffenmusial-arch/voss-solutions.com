<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Voss Solutions — Growth Infrastructure</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,300&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">

<style>
  :root {
    --black: #050507;
    --deep: #0a0a10;
    --card: #0f0f18;
    --border: rgba(255,255,255,0.07);
    --white: #f0eee8;
    --gold: #c8a96e;
    --gold-light: #e8c98e;
    --electric: #4af4b8;
    --electric-dim: rgba(74,244,184,0.12);
    --red: #ff4444;
    --text-muted: rgba(240,238,232,0.45);
    --text-mid: rgba(240,238,232,0.72);
  }

  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  html { scroll-behavior: smooth; }

  body {
    background: var(--black);
    color: var(--white);
    font-family: 'DM Sans', sans-serif;
    font-size: 16px;
    line-height: 1.65;
    overflow-x: hidden;
    cursor: none;
  }

  /* ── CUSTOM CURSOR ── */
  #cursor {
    position: fixed; top: 0; left: 0; z-index: 9999;
    width: 10px; height: 10px;
    background: var(--electric);
    border-radius: 50%;
    pointer-events: none;
    transform: translate(-50%,-50%);
    transition: width .15s, height .15s, background .15s;
  }
  #cursor-ring {
    position: fixed; top: 0; left: 0; z-index: 9998;
    width: 36px; height: 36px;
    border: 1.5px solid rgba(74,244,184,0.45);
    border-radius: 50%;
    pointer-events: none;
    transform: translate(-50%,-50%);
    transition: all .25s cubic-bezier(.23,1,.32,1);
  }
  body:hover #cursor { opacity: 1; }

  /* ── CANVAS BACKGROUND ── */
  #bg-canvas {
    position: fixed; inset: 0; z-index: 0;
    pointer-events: none;
    opacity: 0.55;
  }

  /* ── NAV ── */
  nav {
    position: fixed; top: 0; left: 0; right: 0; z-index: 100;
    display: flex; align-items: center; justify-content: space-between;
    padding: 22px 60px;
    background: rgba(5,5,7,0.7);
    backdrop-filter: blur(18px);
    border-bottom: 1px solid var(--border);
    transition: padding .3s;
  }
  nav.scrolled { padding: 14px 60px; }

  .nav-logo {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 28px;
    letter-spacing: 3px;
    color: var(--white);
    text-decoration: none;
  }
  .nav-logo span { color: var(--gold); }

  .nav-links { display: flex; gap: 36px; align-items: center; }
  .nav-links a {
    font-size: 13px;
    font-weight: 500;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: var(--text-muted);
    text-decoration: none;
    transition: color .2s;
    cursor: none;
  }
  .nav-links a:hover { color: var(--white); }

  .nav-cta {
    font-family: 'Space Mono', monospace;
    font-size: 12px;
    letter-spacing: 1px;
    color: var(--black) !important;
    background: var(--electric);
    padding: 10px 22px;
    border-radius: 2px;
    text-decoration: none;
    font-weight: 700;
    transition: background .2s, transform .2s !important;
    cursor: none;
  }
  .nav-cta:hover { background: var(--gold) !important; transform: translateY(-1px); }

  /* ── SECTIONS ── */
  section { position: relative; z-index: 1; }

  /* ── HERO ── */
  #hero {
    min-height: 100vh;
    display: flex; flex-direction: column;
    justify-content: center;
    padding: 160px 60px 100px;
    overflow: hidden;
  }

  .hero-eyebrow {
    font-family: 'Space Mono', monospace;
    font-size: 11px;
    letter-spacing: 4px;
    color: var(--electric);
    text-transform: uppercase;
    margin-bottom: 28px;
    opacity: 0;
    animation: fadeUp .8s ease forwards .2s;
    display: flex; align-items: center; gap: 14px;
  }
  .hero-eyebrow::before {
    content: '';
    display: block; width: 40px; height: 1px;
    background: var(--electric);
  }

  .hero-headline {
    font-family: 'Bebas Neue', sans-serif;
    font-size: clamp(72px, 10vw, 148px);
    line-height: .92;
    letter-spacing: 2px;
    max-width: 1000px;
    opacity: 0;
    animation: fadeUp .9s ease forwards .4s;
  }
  .hero-headline .line2 { color: var(--gold); display: block; }
  .hero-headline .outline {
    -webkit-text-stroke: 1.5px var(--white);
    color: transparent;
  }

  .hero-sub {
    font-size: 18px;
    font-weight: 300;
    color: var(--text-mid);
    max-width: 520px;
    margin-top: 32px;
    line-height: 1.75;
    opacity: 0;
    animation: fadeUp .9s ease forwards .65s;
  }
  .hero-sub strong { color: var(--white); font-weight: 500; }

  .hero-actions {
    display: flex; gap: 18px; align-items: center;
    margin-top: 48px;
    opacity: 0;
    animation: fadeUp .9s ease forwards .85s;
    flex-wrap: wrap;
  }

  .btn-primary {
    font-family: 'Space Mono', monospace;
    font-size: 13px;
    letter-spacing: 1.5px;
    font-weight: 700;
    text-transform: uppercase;
    text-decoration: none;
    color: var(--black);
    background: var(--electric);
    padding: 16px 36px;
    border-radius: 2px;
    cursor: none;
    position: relative; overflow: hidden;
    transition: transform .2s;
  }
  .btn-primary::after {
    content: '';
    position: absolute; inset: 0;
    background: var(--gold);
    transform: translateX(-101%);
    transition: transform .3s cubic-bezier(.77,0,.18,1);
  }
  .btn-primary:hover::after { transform: translateX(0); }
  .btn-primary:hover { transform: translateY(-2px); }
  .btn-primary span { position: relative; z-index: 1; }

  .btn-ghost {
    font-size: 13px;
    letter-spacing: 1px;
    text-decoration: none;
    color: var(--text-mid);
    display: flex; align-items: center; gap: 10px;
    cursor: none;
    transition: color .2s;
  }
  .btn-ghost:hover { color: var(--white); }
  .btn-ghost-arrow {
    width: 36px; height: 36px;
    border: 1px solid var(--border);
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 16px;
    transition: border-color .2s, background .2s;
  }
  .btn-ghost:hover .btn-ghost-arrow {
    border-color: var(--electric);
    background: var(--electric-dim);
    color: var(--electric);
  }

  .hero-stats {
    display: flex; gap: 60px;
    margin-top: 80px;
    padding-top: 48px;
    border-top: 1px solid var(--border);
    opacity: 0;
    animation: fadeUp .9s ease forwards 1.1s;
    flex-wrap: wrap;
  }
  .stat-num {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 52px;
    color: var(--gold);
    letter-spacing: 2px;
    line-height: 1;
  }
  .stat-label {
    font-size: 12px;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: var(--text-muted);
    margin-top: 6px;
  }

  /* Scrolling ticker */
  .ticker-wrap {
    overflow: hidden;
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
    padding: 18px 0;
    background: rgba(74,244,184,0.03);
  }
  .ticker {
    display: flex;
    width: max-content;
    animation: ticker 28s linear infinite;
    gap: 0;
  }
  .ticker-item {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 22px;
    letter-spacing: 4px;
    padding: 0 48px;
    color: var(--text-muted);
    white-space: nowrap;
  }
  .ticker-item span { color: var(--electric); margin-right: 12px; }

  @keyframes ticker {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
  }

  /* ── SERVICES ── */
  #services { padding: 120px 60px; }

  .section-label {
    font-family: 'Space Mono', monospace;
    font-size: 10px;
    letter-spacing: 4px;
    text-transform: uppercase;
    color: var(--electric);
    margin-bottom: 20px;
    display: flex; align-items: center; gap: 12px;
  }
  .section-label::before {
    content: '';
    display: block; width: 28px; height: 1px;
    background: var(--electric);
  }

  .section-title {
    font-family: 'Bebas Neue', sans-serif;
    font-size: clamp(48px, 6vw, 88px);
    line-height: .95;
    letter-spacing: 1px;
    max-width: 700px;
    margin-bottom: 70px;
  }
  .section-title em {
    font-style: normal;
    color: var(--gold);
  }

  .services-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2px;
  }

  .service-card {
    background: var(--card);
    border: 1px solid var(--border);
    padding: 52px 44px;
    position: relative;
    overflow: hidden;
    cursor: none;
    transition: border-color .3s, transform .3s;
  }
  .service-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--electric), var(--gold));
    transform: scaleX(0);
    transform-origin: left;
    transition: transform .4s cubic-bezier(.77,0,.18,1);
  }
  .service-card:hover { border-color: rgba(74,244,184,0.2); transform: translateY(-4px); }
  .service-card:hover::before { transform: scaleX(1); }

  .service-icon {
    width: 52px; height: 52px;
    background: var(--electric-dim);
    border: 1px solid rgba(74,244,184,0.2);
    border-radius: 4px;
    display: flex; align-items: center; justify-content: center;
    font-size: 22px;
    margin-bottom: 32px;
  }

  .service-tag {
    font-family: 'Space Mono', monospace;
    font-size: 10px;
    letter-spacing: 2px;
    color: var(--electric);
    text-transform: uppercase;
    margin-bottom: 14px;
  }

  .service-name {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 38px;
    letter-spacing: 1.5px;
    line-height: 1;
    margin-bottom: 18px;
  }

  .service-desc {
    font-size: 15px;
    color: var(--text-mid);
    line-height: 1.7;
    margin-bottom: 32px;
  }

  .service-features {
    list-style: none;
    display: flex; flex-direction: column; gap: 10px;
  }
  .service-features li {
    font-size: 13px;
    color: var(--text-muted);
    display: flex; align-items: center; gap: 10px;
  }
  .service-features li::before {
    content: '→';
    color: var(--electric);
    font-size: 11px;
  }

  .service-card.featured {
    background: linear-gradient(145deg, rgba(74,244,184,0.06), rgba(200,169,110,0.04));
    border-color: rgba(74,244,184,0.18);
    grid-row: span 1;
  }

  /* ── HOW IT WORKS ── */
  #process { padding: 120px 60px; background: var(--deep); }

  .process-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 80px;
    align-items: center;
    margin-top: 60px;
  }

  .process-steps { display: flex; flex-direction: column; gap: 0; }

  .process-step {
    display: flex; gap: 28px;
    padding: 36px 0;
    border-bottom: 1px solid var(--border);
    cursor: none;
    transition: background .2s;
  }
  .process-step:first-child { border-top: 1px solid var(--border); }

  .step-num {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 58px;
    color: rgba(255,255,255,0.06);
    line-height: 1;
    min-width: 60px;
    transition: color .3s;
  }
  .process-step:hover .step-num { color: var(--gold); }

  .step-content h3 {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 26px;
    letter-spacing: 1px;
    margin-bottom: 8px;
    transition: color .3s;
  }
  .process-step:hover .step-content h3 { color: var(--electric); }

  .step-content p {
    font-size: 14px;
    color: var(--text-muted);
    line-height: 1.7;
  }

  .process-visual {
    position: relative;
    height: 460px;
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 4px;
    overflow: hidden;
    display: flex; align-items: center; justify-content: center;
  }

  .visual-chart {
    position: absolute; inset: 0;
    display: flex; align-items: flex-end;
    gap: 10px;
    padding: 40px 36px 36px;
  }

  .chart-bar {
    flex: 1;
    background: linear-gradient(0deg, rgba(74,244,184,0.6), rgba(74,244,184,0.1));
    border-radius: 2px 2px 0 0;
    position: relative;
    animation: barGrow 1.4s cubic-bezier(.23,1,.32,1) forwards;
    transform-origin: bottom;
    transform: scaleY(0);
  }
  @keyframes barGrow {
    to { transform: scaleY(1); }
  }

  .chart-label {
    position: absolute; bottom: -22px; left: 50%; transform: translateX(-50%);
    font-family: 'Space Mono', monospace;
    font-size: 9px;
    color: var(--text-muted);
    white-space: nowrap;
  }
  .chart-value {
    position: absolute; top: -24px; left: 50%; transform: translateX(-50%);
    font-family: 'Space Mono', monospace;
    font-size: 10px;
    color: var(--electric);
    white-space: nowrap;
  }

  .visual-overlay {
    position: absolute; top: 20px; left: 20px; right: 20px;
    display: flex; justify-content: space-between; align-items: flex-start;
  }

  .visual-badge {
    background: rgba(74,244,184,0.1);
    border: 1px solid rgba(74,244,184,0.25);
    padding: 8px 14px;
    border-radius: 2px;
    font-family: 'Space Mono', monospace;
    font-size: 10px;
    color: var(--electric);
  }

  /* ── PROOF / RESULTS ── */
  #results { padding: 120px 60px; }

  .results-intro {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 80px;
    align-items: end;
    margin-bottom: 70px;
  }

  .results-body {
    font-size: 17px;
    color: var(--text-mid);
    line-height: 1.8;
    max-width: 460px;
  }
  .results-body strong { color: var(--white); font-weight: 500; }

  .result-cards {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2px;
  }

  .result-card {
    background: var(--card);
    border: 1px solid var(--border);
    padding: 44px 36px;
    position: relative;
    overflow: hidden;
  }

  .result-metric {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 72px;
    line-height: 1;
    letter-spacing: 2px;
    background: linear-gradient(135deg, var(--electric), var(--gold));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 10px;
  }

  .result-label {
    font-size: 14px;
    color: var(--text-mid);
    line-height: 1.5;
  }

  .result-context {
    font-family: 'Space Mono', monospace;
    font-size: 10px;
    color: var(--text-muted);
    margin-top: 14px;
    letter-spacing: 1px;
  }

  /* ── PRICING / PACKAGES ── */
  #packages { padding: 120px 60px; background: var(--deep); }

  .packages-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2px;
    margin-top: 60px;
  }

  .package-card {
    background: var(--card);
    border: 1px solid var(--border);
    padding: 52px 40px;
    position: relative;
    overflow: hidden;
    cursor: none;
    transition: border-color .3s, transform .3s;
  }

  .package-card.highlight {
    background: linear-gradient(160deg, rgba(74,244,184,0.07), rgba(200,169,110,0.05), transparent);
    border-color: rgba(74,244,184,0.25);
  }

  .package-card.highlight::after {
    content: 'MOST POPULAR';
    position: absolute;
    top: 24px; right: 24px;
    font-family: 'Space Mono', monospace;
    font-size: 9px;
    letter-spacing: 2px;
    color: var(--black);
    background: var(--electric);
    padding: 5px 10px;
    border-radius: 1px;
  }

  .package-card:hover { transform: translateY(-4px); border-color: rgba(74,244,184,0.2); }

  .package-name {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 42px;
    letter-spacing: 2px;
    margin-bottom: 6px;
  }

  .package-tagline {
    font-size: 13px;
    color: var(--text-muted);
    margin-bottom: 36px;
    font-style: italic;
    font-weight: 300;
  }

  .package-price {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 56px;
    letter-spacing: 2px;
    color: var(--gold);
    line-height: 1;
    margin-bottom: 8px;
  }
  .package-price sup {
    font-size: 24px;
    vertical-align: top;
    margin-top: 10px;
    display: inline-block;
  }
  .package-freq {
    font-size: 12px;
    color: var(--text-muted);
    margin-bottom: 36px;
  }

  .package-list {
    list-style: none;
    display: flex; flex-direction: column; gap: 13px;
    margin-bottom: 40px;
  }
  .package-list li {
    font-size: 14px;
    color: var(--text-mid);
    display: flex; gap: 10px; align-items: flex-start;
  }
  .package-list li .check {
    color: var(--electric);
    font-size: 12px;
    margin-top: 2px;
    flex-shrink: 0;
  }

  .btn-package {
    display: block;
    text-align: center;
    font-family: 'Space Mono', monospace;
    font-size: 12px;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    text-decoration: none;
    padding: 15px;
    border: 1.5px solid var(--border);
    color: var(--text-mid);
    border-radius: 2px;
    transition: all .2s;
    cursor: none;
  }
  .btn-package:hover, .package-card.highlight .btn-package {
    background: var(--electric);
    border-color: var(--electric);
    color: var(--black);
  }

  /* ── CTA ── */
  #cta {
    padding: 140px 60px;
    text-align: center;
    position: relative;
    overflow: hidden;
  }
  #cta::before {
    content: '';
    position: absolute;
    top: 50%; left: 50%; transform: translate(-50%,-50%);
    width: 700px; height: 700px;
    background: radial-gradient(circle, rgba(74,244,184,0.06) 0%, transparent 70%);
    pointer-events: none;
  }

  .cta-headline {
    font-family: 'Bebas Neue', sans-serif;
    font-size: clamp(56px, 8vw, 116px);
    line-height: .92;
    letter-spacing: 2px;
    max-width: 900px;
    margin: 0 auto 36px;
  }
  .cta-headline .gold { color: var(--gold); }
  .cta-headline .outline {
    -webkit-text-stroke: 1.5px rgba(255,255,255,0.35);
    color: transparent;
  }

  .cta-sub {
    font-size: 17px;
    color: var(--text-mid);
    max-width: 480px;
    margin: 0 auto 52px;
    line-height: 1.75;
  }

  /* ── FOOTER ── */
  footer {
    padding: 60px;
    border-top: 1px solid var(--border);
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 24px;
  }
  .footer-logo {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 24px;
    letter-spacing: 3px;
    text-decoration: none;
    color: var(--white);
  }
  .footer-logo span { color: var(--gold); }
  .footer-copy {
    font-size: 12px;
    color: var(--text-muted);
    font-family: 'Space Mono', monospace;
  }
  .footer-links { display: flex; gap: 28px; }
  .footer-links a {
    font-size: 12px;
    color: var(--text-muted);
    text-decoration: none;
    letter-spacing: 1px;
    transition: color .2s;
    cursor: none;
  }
  .footer-links a:hover { color: var(--white); }

  /* ── ANIMATIONS ── */
  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(32px); }
    to { opacity: 1; transform: translateY(0); }
  }

  .reveal {
    opacity: 0;
    transform: translateY(40px);
    transition: opacity .75s ease, transform .75s ease;
  }
  .reveal.visible {
    opacity: 1;
    transform: translateY(0);
  }

  /* Noise overlay */
  body::after {
    content: '';
    position: fixed; inset: 0; z-index: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
    pointer-events: none;
    opacity: .5;
  }

  /* Grid lines decoration */
  .grid-lines {
    position: absolute;
    inset: 0; z-index: 0;
    background-image:
      linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
    background-size: 80px 80px;
    pointer-events: none;
  }

  /* Glowing divider */
  .glow-divider {
    height: 1px;
    background: linear-gradient(90deg, transparent, var(--electric), transparent);
    opacity: 0.4;
    margin: 0;
  }

  /* Mobile responsiveness */
  @media (max-width: 900px) {
    nav { padding: 18px 24px; }
    nav.scrolled { padding: 12px 24px; }
    .nav-links { display: none; }
    #hero, #services, #process, #results, #packages, #cta, footer { padding-left: 24px; padding-right: 24px; }
    .hero-headline { font-size: clamp(56px, 14vw, 100px); }
    .services-grid, .result-cards, .packages-grid { grid-template-columns: 1fr; }
    .process-grid { grid-template-columns: 1fr; }
    .process-visual { height: 300px; }
    .results-intro { grid-template-columns: 1fr; gap: 30px; }
    .hero-stats { gap: 32px; }
  }
</style>
</head>
<body>

<div id="cursor"></div>
<div id="cursor-ring"></div>
<canvas id="bg-canvas"></canvas>

<!-- NAV -->
<nav id="navbar">
  <a href="#" class="nav-logo">VOSS<span>.</span></a>
  <div class="nav-links">
    <a href="#services">Services</a>
    <a href="#process">Process</a>
    <a href="#results">Results</a>
    <a href="#packages">Packages</a>
    <a href="#cta" class="nav-cta"><span>Get Started</span></a>
  </div>
</nav>

<!-- HERO -->
<section id="hero">
  <div class="grid-lines"></div>

  <div class="hero-eyebrow">Growth Infrastructure for Modern Businesses</div>

  <h1 class="hero-headline">
    YOUR BUSINESS<br>
    <span class="line2">DESERVES TO</span><br>
    <span class="outline">DOMINATE.</span>
  </h1>

  <p class="hero-sub">
    Most businesses are invisible online. <strong>Voss Solutions</strong> builds the systems that put you in front of the right people — at the exact moment they're ready to buy.
  </p>

  <div class="hero-actions">
    <a href="#packages" class="btn-primary"><span>See What We Build →</span></a>
    <a href="#process" class="btn-ghost">
      <div class="btn-ghost-arrow">↓</div>
      How it works
    </a>
  </div>

  <div class="hero-stats">
    <div>
      <div class="stat-num">3.8×</div>
      <div class="stat-label">Avg. Return on Ad Spend</div>
    </div>
    <div>
      <div class="stat-num">14</div>
      <div class="stat-label">Days to First Results</div>
    </div>
    <div>
      <div class="stat-num">100%</div>
      <div class="stat-label">Transparent Reporting</div>
    </div>
  </div>
</section>

<!-- TICKER -->
<div class="ticker-wrap">
  <div class="ticker">
    <div class="ticker-item"><span>✦</span> GOOGLE ADS MANAGEMENT</div>
    <div class="ticker-item"><span>✦</span> CONVERSION-OPTIMIZED WEBSITES</div>
    <div class="ticker-item"><span>✦</span> FULL GROWTH INFRASTRUCTURE</div>
    <div class="ticker-item"><span>✦</span> LANDING PAGE DESIGN</div>
    <div class="ticker-item"><span>✦</span> PERFORMANCE TRACKING</div>
    <div class="ticker-item"><span>✦</span> GOOGLE ADS MANAGEMENT</div>
    <div class="ticker-item"><span>✦</span> CONVERSION-OPTIMIZED WEBSITES</div>
    <div class="ticker-item"><span>✦</span> FULL GROWTH INFRASTRUCTURE</div>
    <div class="ticker-item"><span>✦</span> LANDING PAGE DESIGN</div>
    <div class="ticker-item"><span>✦</span> PERFORMANCE TRACKING</div>
  </div>
</div>

<!-- SERVICES -->
<section id="services">
  <div class="section-label">What We Do</div>
  <h2 class="section-title reveal">Three Ways to <em>Grow.</em></h2>

  <div class="services-grid">
    <!-- Card 1 -->
    <div class="service-card reveal">
      <div class="service-icon">📡</div>
      <div class="service-tag">Service 01</div>
      <div class="service-name">SIGNAL<br>ADS</div>
      <p class="service-desc">
        Google Ads that find your next customer before they even finish typing. We manage every campaign, keyword, and budget — so you spend less and win more.
      </p>
      <ul class="service-features">
        <li>Full Google Ads setup & management</li>
        <li>Keyword research & competitor analysis</li>
        <li>Weekly performance reports</li>
        <li>Ongoing A/B testing & optimization</li>
      </ul>
    </div>

    <!-- Card 2: Featured -->
    <div class="service-card featured reveal">
      <div class="service-icon">⚙️</div>
      <div class="service-tag">Service 02 — Most Popular</div>
      <div class="service-name">FULL<br>STACK</div>
      <p class="service-desc">
        The complete growth engine. A website that builds trust the moment someone lands on it — plus the ads that send them there. This is what serious businesses are built on.
      </p>
      <ul class="service-features">
        <li>Everything in Signal Ads</li>
        <li>Custom website or landing page</li>
        <li>Copywriting built to convert</li>
        <li>Funnel strategy & CRO</li>
        <li>Monthly growth reviews</li>
      </ul>
    </div>

    <!-- Card 3 -->
    <div class="service-card reveal">
      <div class="service-icon">🌐</div>
      <div class="service-tag">Service 03</div>
      <div class="service-name">FRONT<br>STAGE</div>
      <p class="service-desc">
        Your website is your handshake. Make it count. We build clean, modern sites that make you look like the premium option in your market — because you are.
      </p>
      <ul class="service-features">
        <li>Custom website design & build</li>
        <li>Professional copywriting</li>
        <li>Mobile-first & fast-loading</li>
        <li>SEO-ready structure</li>
      </ul>
    </div>
  </div>
</section>

<div class="glow-divider"></div>

<!-- PROCESS -->
<section id="process">
  <div class="section-label">How It Works</div>
  <div class="process-grid">
    <div>
      <h2 class="section-title reveal">From Zero<br>to <em>Visible.</em></h2>
      <div class="process-steps">
        <div class="process-step reveal">
          <div class="step-num">01</div>
          <div class="step-content">
            <h3>Strategy Call</h3>
            <p>We learn your business, your goals, and what's standing between you and more customers. No fluff — just a clear plan of attack.</p>
          </div>
        </div>
        <div class="process-step reveal">
          <div class="step-num">02</div>
          <div class="step-content">
            <h3>Build the Infrastructure</h3>
            <p>We set up your campaigns, design your pages, and write copy that speaks to the real desires of your customers. Done in days, not months.</p>
          </div>
        </div>
        <div class="process-step reveal">
          <div class="step-num">03</div>
          <div class="step-content">
            <h3>Launch & Optimize</h3>
            <p>We go live and monitor every metric. Every week we improve — testing, tightening, and turning more clicks into customers.</p>
          </div>
        </div>
        <div class="process-step reveal">
          <div class="step-num">04</div>
          <div class="step-content">
            <h3>You Scale</h3>
            <p>When the system works, we scale it. More budget, more reach, more revenue. Your only job is handling the new business.</p>
          </div>
        </div>
      </div>
    </div>

    <div class="process-visual reveal">
      <div class="visual-overlay">
        <div class="visual-badge">LIVE PERFORMANCE</div>
        <div class="visual-badge" style="color:var(--gold); border-color:rgba(200,169,110,0.3); background:rgba(200,169,110,0.08);">+312% Revenue</div>
      </div>
      <div class="visual-chart" id="chart-container">
        <!-- Bars injected by JS -->
      </div>
    </div>
  </div>
</section>

<div class="glow-divider"></div>

<!-- RESULTS -->
<section id="results">
  <div class="results-intro">
    <div>
      <div class="section-label">The Numbers</div>
      <h2 class="section-title reveal">Results That<br><em>Matter.</em></h2>
    </div>
    <p class="results-body reveal">
      We don't talk about "brand awareness" or "impressions." We talk about <strong>customers, revenue, and return.</strong> Every decision we make is tied to one question: does this bring more business through the door?
    </p>
  </div>

  <div class="result-cards">
    <div class="result-card reveal">
      <div class="result-metric">3.8×</div>
      <div class="result-label">Average return on Google Ads spend across all clients</div>
      <div class="result-context">↑ FROM INDUSTRY AVG OF 2.1×</div>
    </div>
    <div class="result-card reveal">
      <div class="result-metric">62%</div>
      <div class="result-label">Average increase in website conversion rate after redesign</div>
      <div class="result-context">↑ MORE LEADS, SAME TRAFFIC</div>
    </div>
    <div class="result-card reveal">
      <div class="result-metric">14</div>
      <div class="result-label">Days from onboarding to first campaign live</div>
      <div class="result-context">↓ FASTER THAN MOST AGENCIES</div>
    </div>
  </div>
</section>

<div class="glow-divider"></div>

<!-- PACKAGES -->
<section id="packages">
  <div class="section-label">Pricing</div>
  <h2 class="section-title reveal">Pick Your<br><em>Weapon.</em></h2>

  <div class="packages-grid">
    <!-- Starter -->
    <div class="package-card reveal">
      <div class="package-name">FRONT<br>STAGE</div>
      <div class="package-tagline">Look like the premium option.</div>
      <div class="package-price"><sup>€</sup>997</div>
      <div class="package-freq">one-time</div>
      <ul class="package-list">
        <li><span class="check">✓</span> Custom website design & build</li>
        <li><span class="check">✓</span> Professional copywriting</li>
        <li><span class="check">✓</span> Mobile-first, fast-loading</li>
        <li><span class="check">✓</span> SEO-ready structure</li>
        <li><span class="check">✓</span> 30 days of support</li>
      </ul>
      <a href="#cta" class="btn-package">Get Started →</a>
    </div>

    <!-- Core (highlighted) -->
    <div class="package-card highlight reveal">
      <div class="package-name">SIGNAL<br>ADS</div>
      <div class="package-tagline">Be found. Get customers.</div>
      <div class="package-price"><sup>€</sup>597</div>
      <div class="package-freq">per month</div>
      <ul class="package-list">
        <li><span class="check">✓</span> Full Google Ads management</li>
        <li><span class="check">✓</span> Keyword research & strategy</li>
        <li><span class="check">✓</span> Ad copy creation & testing</li>
        <li><span class="check">✓</span> Weekly optimization</li>
        <li><span class="check">✓</span> Monthly performance report</li>
        <li><span class="check">✓</span> Direct access to your manager</li>
      </ul>
      <a href="#cta" class="btn-package">Get Started →</a>
    </div>

    <!-- Full Stack -->
    <div class="package-card reveal">
      <div class="package-name">FULL<br>STACK</div>
      <div class="package-tagline">The complete growth system.</div>
      <div class="package-price"><sup>€</sup>1,197</div>
      <div class="package-freq">per month + one-time setup</div>
      <ul class="package-list">
        <li><span class="check">✓</span> Everything in Signal Ads</li>
        <li><span class="check">✓</span> Custom website or landing page</li>
        <li><span class="check">✓</span> Conversion copywriting</li>
        <li><span class="check">✓</span> Funnel strategy & CRO</li>
        <li><span class="check">✓</span> Priority support</li>
        <li><span class="check">✓</span> Quarterly growth strategy call</li>
      </ul>
      <a href="#cta" class="btn-package">Get Started →</a>
    </div>
  </div>
</section>

<div class="glow-divider"></div>

<!-- CTA -->
<section id="cta">
  <div class="section-label" style="justify-content:center; margin-bottom:32px;">Ready?</div>
  <h2 class="cta-headline reveal">
    STOP LEAVING<br>
    <span class="gold">MONEY</span><br>
    <span class="outline">ON THE TABLE.</span>
  </h2>
  <p class="cta-sub reveal">
    Every day without a system is a day your competitors get the customer that should have been yours. Let's change that.
  </p>
  <a href="mailto:hello@vosssolutions.com" class="btn-primary reveal" style="display:inline-block; font-size:14px; padding:20px 52px;">
    <span>Book a Free Strategy Call →</span>
  </a>
</section>

<!-- FOOTER -->
<footer>
  <a href="#" class="footer-logo">VOSS<span>.</span></a>
  <div class="footer-links">
    <a href="#services">Services</a>
    <a href="#process">Process</a>
    <a href="#packages">Packages</a>
    <a href="mailto:hello@vosssolutions.com">Contact</a>
  </div>
  <div class="footer-copy">© 2025 Voss Solutions. All rights reserved.</div>
</footer>

<script>
// ── CUSTOM CURSOR ──
const cursor = document.getElementById('cursor');
const ring = document.getElementById('cursor-ring');
let mx = 0, my = 0, rx = 0, ry = 0;
document.addEventListener('mousemove', e => { mx = e.clientX; my = e.clientY; });
(function animCursor() {
  cursor.style.left = mx + 'px'; cursor.style.top = my + 'px';
  rx += (mx - rx) * 0.12; ry += (my - ry) * 0.12;
  ring.style.left = rx + 'px'; ring.style.top = ry + 'px';
  requestAnimationFrame(animCursor);
})();
document.querySelectorAll('a, button, .service-card, .package-card, .process-step').forEach(el => {
  el.addEventListener('mouseenter', () => {
    cursor.style.width = '16px'; cursor.style.height = '16px';
    ring.style.width = '56px'; ring.style.height = '56px';
    ring.style.borderColor = 'rgba(200,169,110,0.6)';
  });
  el.addEventListener('mouseleave', () => {
    cursor.style.width = '10px'; cursor.style.height = '10px';
    ring.style.width = '36px'; ring.style.height = '36px';
    ring.style.borderColor = 'rgba(74,244,184,0.45)';
  });
});

// ── PARTICLE CANVAS ──
const canvas = document.getElementById('bg-canvas');
const ctx = canvas.getContext('2d');
let W, H, particles = [];
function resize() { W = canvas.width = window.innerWidth; H = canvas.height = window.innerHeight; }
resize(); window.addEventListener('resize', resize);

class Particle {
  constructor() { this.reset(); }
  reset() {
    this.x = Math.random() * W;
    this.y = Math.random() * H;
    this.r = Math.random() * 1.2 + 0.2;
    this.vx = (Math.random() - 0.5) * 0.25;
    this.vy = (Math.random() - 0.5) * 0.25;
    this.alpha = Math.random() * 0.5 + 0.1;
    this.color = Math.random() > 0.65 ? '#4af4b8' : '#c8a96e';
  }
  update() {
    this.x += this.vx; this.y += this.vy;
    if (this.x < 0 || this.x > W || this.y < 0 || this.y > H) this.reset();
  }
  draw() {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.r, 0, Math.PI * 2);
    ctx.fillStyle = this.color;
    ctx.globalAlpha = this.alpha;
    ctx.fill();
    ctx.globalAlpha = 1;
  }
}

for (let i = 0; i < 120; i++) particles.push(new Particle());

function drawConnections() {
  for (let i = 0; i < particles.length; i++) {
    for (let j = i + 1; j < particles.length; j++) {
      const dx = particles[i].x - particles[j].x;
      const dy = particles[i].y - particles[j].y;
      const d = Math.sqrt(dx*dx + dy*dy);
      if (d < 110) {
        ctx.beginPath();
        ctx.moveTo(particles[i].x, particles[i].y);
        ctx.lineTo(particles[j].x, particles[j].y);
        ctx.strokeStyle = '#4af4b8';
        ctx.globalAlpha = (1 - d/110) * 0.08;
        ctx.lineWidth = 0.5;
        ctx.stroke();
        ctx.globalAlpha = 1;
      }
    }
  }
}

function animParticles() {
  ctx.clearRect(0, 0, W, H);
  particles.forEach(p => { p.update(); p.draw(); });
  drawConnections();
  requestAnimationFrame(animParticles);
}
animParticles();

// ── NAV SCROLL ──
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
  navbar.classList.toggle('scrolled', window.scrollY > 60);
});

// ── SCROLL REVEAL ──
const reveals = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver(entries => {
  entries.forEach((entry, i) => {
    if (entry.isIntersecting) {
      setTimeout(() => entry.target.classList.add('visible'), i % 3 * 100);
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.12 });
reveals.forEach(el => observer.observe(el));

// ── CHART BARS ──
const months = [
  { label: 'Jan', val: 28, h: 22 },
  { label: 'Feb', val: 41, h: 33 },
  { label: 'Mar', val: 38, h: 30 },
  { label: 'Apr', val: 56, h: 44 },
  { label: 'May', val: 72, h: 58 },
  { label: 'Jun', val: 68, h: 54 },
  { label: 'Jul', val: 88, h: 70 },
  { label: 'Aug', val: 102, h: 82 },
  { label: 'Sep', val: 97, h: 78 },
  { label: 'Oct', val: 118, h: 94 },
  { label: 'Nov', val: 134, h: 100 },
  { label: 'Dec', val: 149, h: 100 },
];
const container = document.getElementById('chart-container');
months.forEach((m, i) => {
  const bar = document.createElement('div');
  bar.className = 'chart-bar';
  bar.style.height = m.h + '%';
  bar.style.animationDelay = (0.1 + i * 0.07) + 's';
  if (i >= 9) {
    bar.style.background = 'linear-gradient(0deg, rgba(200,169,110,0.8), rgba(200,169,110,0.15))';
  }
  bar.innerHTML = `<span class="chart-value">€${m.val}k</span><span class="chart-label">${m.label}</span>`;
  container.appendChild(bar);
});

// ── COUNTER ANIMATION ──
function animateCounter(el, target, suffix='') {
  let start = 0;
  const dur = 1800;
  const step = timestamp => {
    if (!start) start = timestamp;
    const progress = Math.min((timestamp - start) / dur, 1);
    const ease = 1 - Math.pow(1 - progress, 3);
    el.textContent = (typeof target === 'float' ? (target * ease).toFixed(1) : Math.floor(target * ease)) + suffix;
    if (progress < 1) requestAnimationFrame(step);
  };
  requestAnimationFrame(step);
}
</script>
</body>
</html>
