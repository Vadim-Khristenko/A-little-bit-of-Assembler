---
title: A Little Bit of Assembler | Language Selection
no_comments: true
---

<style>
  :root {
    --bg-color: #070014;
    --primary-color: #16002b;
    --accent-color: rgba(255, 140, 0, 0.9);
    --text-color: #f0f0f0;
    --button-bg: #2a0049;
    --button-hover-bg: #3b006b;
    --neon-glow: 0 0 5px rgba(255, 140, 0, 0.5), 0 0 10px rgba(255, 140, 0, 0.3);
    --card-bg: rgba(25, 0, 40, 0.7);
    --code-bg: rgba(30, 0, 60, 0.6);
    --primary-color-rgb: 22, 0, 43;
    --accent-color-rgb: 255, 140, 0;
  }
  
  body {
    font-family: 'Segoe UI', 'SF Pro Display', system-ui, -apple-system, sans-serif;
    background-color: var(--bg-color);
    background-image: 
      radial-gradient(circle at 10% 20%, rgba(var(--primary-color-rgb), 0.2) 0%, transparent 30%),
      radial-gradient(circle at 90% 80%, rgba(var(--accent-color-rgb), 0.15) 0%, transparent 40%);
    color: var(--text-color);
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    transition: all 0.5s cubic-bezier(0.22, 1, 0.36, 1);
    overflow-x: hidden;
  }

  .md-typeset h1 {
    color: rgb(0,0,0,0)
  }
  
  .particles {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    pointer-events: none;
  }
  
  .particle {
    position: absolute;
    width: 2px;
    height: 2px;
    background-color: var(--accent-color);
    border-radius: 50%;
    opacity: 0.6;
    animation: float 15s infinite ease-in-out;
  }
  
  @keyframes float {
    0% { transform: translateY(0) translateX(0); opacity: 0; }
    10% { opacity: 0.8; }
    90% { opacity: 0.8; }
    100% { transform: translateY(-100vh) translateX(20px); opacity: 0; }
  }
  
  .main-content {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 2rem;
    text-align: center;
    max-width: 900px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
  }
  
  .card {
    background: var(--card-bg);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 16px;
    padding: 3rem;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.1);
    width: 100%;
    max-width: 700px;
    transform: translateY(30px);
    opacity: 0;
    animation: slideUp 1s cubic-bezier(0.22, 1, 0.36, 1) forwards;
  }
  
  @keyframes slideUp {
    to {
      transform: translateY(0);
      opacity: 1;
    }
  }
  
  .logo-container {
    width: 120px;
    height: 120px;
    margin: 0 auto 2rem;
    position: relative;
    perspective: 1200px;
  }
  
  .logo {
    width: 100%;
    height: 100%;
    position: relative;
    transform-style: preserve-3d;
    transition: transform 1s ease-in-out;
    animation: rotate3d 8s infinite ease-in-out;
  }
  
  .logo-face {
    position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'JetBrains Mono', monospace;
    font-weight: bold;
    border: 2px solid rgba(255, 255, 255, 0.2);
    box-sizing: border-box;
    backface-visibility: visible;
    transition: all 0.5s ease;
  }
  
  .theme-dark .logo-face {
    color: #fff;
    box-shadow: inset 0 0 15px rgba(0, 0, 0, 0.3);
  }
  
  .theme-dark .logo-front {
    background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
    transform: translateZ(60px);
    border-radius: 12px;
    font-size: 28px;
  }
  
  .theme-dark .logo-back {
    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
    transform: rotateY(180deg) translateZ(60px);
    border-radius: 12px;
    font-size: 28px;
  }
  
  .theme-dark .logo-right {
    background: rgba(var(--primary-color-rgb), 0.8);
    transform: rotateY(90deg) translateZ(60px);
    font-size: 20px;
  }
  
  .theme-dark .logo-left {
    background: rgba(var(--primary-color-rgb), 0.8);
    transform: rotateY(-90deg) translateZ(60px);
    font-size: 20px;
  }
  
  .theme-dark .logo-top {
    background: rgba(var(--primary-color-rgb), 0.7);
    transform: rotateX(90deg) translateZ(60px);
    font-size: 22px;
  }
  
  .theme-dark .logo-bottom {
    background: rgba(var(--primary-color-rgb), 0.7);
    transform: rotateX(-90deg) translateZ(60px);
    font-size: 22px;
  }
  
  .theme-light .logo-face {
    color: #333;
    box-shadow: inset 0 0 15px rgba(255, 255, 255, 0.3);
  }
  
  .theme-light .logo-front {
    background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
    transform: translateZ(60px);
    border-radius: 12px;
    font-size: 28px;
  }
  
  .theme-light .logo-back {
    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
    transform: rotateY(180deg) translateZ(60px);
    border-radius: 12px;
    font-size: 28px;
  }
  
  .theme-light .logo-right {
    background: rgba(var(--primary-color-rgb), 0.8);
    transform: rotateY(90deg) translateZ(60px);
    font-size: 20px;
  }
  
  .theme-light .logo-left {
    background: rgba(var(--primary-color-rgb), 0.8);
    transform: rotateY(-90deg) translateZ(60px);
    font-size: 20px;
  }
  
  .theme-light .logo-top {
    background: rgba(var(--primary-color-rgb), 0.7);
    transform: rotateX(90deg) translateZ(60px);
    font-size: 22px;
  }
  
  .theme-light .logo-bottom {
    background: rgba(var(--primary-color-rgb), 0.7);
    transform: rotateX(-90deg) translateZ(60px);
    font-size: 22px;
  }
  
  @keyframes rotate3d {
    0%, 100% { transform: rotateY(0deg) rotateX(0deg) rotateZ(0deg); }
    25% { transform: rotateY(90deg) rotateX(20deg) rotateZ(0deg); }
    50% { transform: rotateY(180deg) rotateX(0deg) rotateZ(0deg); }
    75% { transform: rotateY(270deg) rotateX(-20deg) rotateZ(0deg); }
  }
  
  .glow-effect {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 130%;
    height: 130%;
    background: radial-gradient(circle, var(--accent-color) 0%, transparent 70%);
    opacity: 0.3;
    filter: blur(15px);
    animation: pulse 4s infinite ease-in-out;
    pointer-events: none;
  }
  
  @keyframes pulse {
    0%, 100% { opacity: 0.2; transform: translate(-50%, -50%) scale(0.8); }
    50% { opacity: 0.4; transform: translate(-50%, -50%) scale(1); }
  }
  
  .circuit-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M15 10h5v80h-5zm65 0h5v80h-5zM10 15v5h80v-5zm0 65v5h80v-5zM40 40h5v20h-5zm15 0h5v20h-5zM40 40v5h20v-5zm0 15v5h20v-5z' fill='%23ffffff' fill-opacity='0.05'/%3E%3C/svg%3E");
    opacity: 0.2;
    pointer-events: none;
    border-radius: 16px;
    z-index: -1;
  }
  
  /* Основной стиль для заголовка */
  .title {
      font-family: 'JetBrains Mono', monospace;
      font-size: 3rem;
      font-weight: 800;
      margin-bottom: 1rem;
      position: relative;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      transform-style: preserve-3d;
      perspective: 800px;
      cursor: pointer;
      user-select: none;
      transition: transform 0.3s ease;
      padding: 0.2em 0.4em;
      color: transparent;
  }

  .title::before {
      content: "A LITTLE BIT OF ASSEMBLER";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(45deg, var(--accent-color), var(--primary-color), var(--accent-color));
      background-size: 300% 300%;
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
      animation: gradientFlow 8s ease infinite;
      z-index: 2;
      transform: translateZ(60px);
      text-shadow: 0 0 15px rgba(var(--accent-color-rgb), 0.3);
      font-weight: 800;
      transition: text-shadow 0.3s ease;
      white-space: normal;
      word-wrap: break-word;
  }

  @keyframes gradientFlow {
      0%, 100% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
  }

  .theme-dark .title::before {
      --text-shadow-color: rgba(var(--accent-color-rgb), 0.5);
      text-shadow: 0 0 20px var(--text-shadow-color);
  }

  .theme-light .title::before {
      --text-shadow-color: rgba(var(--primary-color-rgb), 0.5);
      text-shadow: 0 0 15px var(--text-shadow-color);
  }
  
  .subtitle {
    font-size: 1.3rem;
    font-weight: 400;
    margin-bottom: 2.5rem;
    opacity: 0.85;
    max-width: 500px;
    margin-left: auto;
    margin-right: auto;
  }
  
  .binary-rain {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    overflow: hidden;
    pointer-events: none;
    z-index: -2;
  }
  
  .binary-column {
    position: absolute;
    top: -100px;
    color: var(--accent-color);
    opacity: 0.15;
    font-family: monospace;
    font-size: 14px;
    animation: binaryRain linear infinite;
  }
  
  @keyframes binaryRain {
    0% { transform: translateY(-100px); opacity: 0; }
    10% { opacity: 0.15; }
    90% { opacity: 0.15; }
    100% { transform: translateY(calc(100vh + 100px)); opacity: 0; }
  }
  
  .matrix-code {
    position: absolute;
    top: -20px;
    color: var(--accent-color);
    font-family: monospace;
    font-size: 12px;
    text-shadow: 0 0 5px var(--accent-color);
    white-space: nowrap;
    z-index: -1;
    opacity: 0;
    animation: matrixCode linear infinite;
  }
  
  @keyframes matrixCode {
    0% { transform: translateY(-50px); opacity: 0; }
    10% { opacity: 0.7; }
    90% { opacity: 0.7; }
    100% { transform: translateY(calc(100vh + 50px)); opacity: 0; }
  }
  
  .loader-container {
    width: 100%;
    max-width: 300px;
    margin: 2rem auto;
    position: relative;
  }
  
  .loader {
    height: 4px;
    width: 100%;
    position: relative;
    overflow: hidden;
    background-color: rgba(255, 255, 255, 0.15);
    border-radius: 4px;
  }
  
  .loader::before {
    content: "";
    position: absolute;
    left: -50%;
    height: 4px;
    width: 40%;
    background: linear-gradient(90deg, transparent, var(--accent-color), transparent);
    animation: loading 2s linear infinite;
    border-radius: 4px;
  }
  
  .loader::after {
    content: "";
    position: absolute;
    top: -6px;
    left: var(--position, 0%);
    width: 16px;
    height: 16px;
    background: var(--accent-color);
    border-radius: 50%;
    box-shadow: 0 0 10px var(--accent-color), 0 0 20px var(--accent-color);
    animation: loadingDot 2s linear infinite;
    opacity: 0.8;
  }
  
  @keyframes loading {
    0% { left: -40%; }
    100% { left: 100%; }
  }
  
  @keyframes loadingDot {
    0% { --position: 0%; }
    100% { --position: 100%; }
  }
  
  .language-selection {
    margin-top: 2rem;
  }
  
  .lang-buttons {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 1.5rem;
  }
  
  .lang-btn {
    padding: 0.9rem 2rem;
    border-radius: 12px;
    text-decoration: none;
    background: linear-gradient(135deg, var(--button-bg), var(--primary-color));
    color: var(--text-color);
    font-weight: 600;
    transition: all 0.3s cubic-bezier(0.22, 1, 0.36, 1);
    border: none;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 130px;
    font-size: 1.1rem;
    letter-spacing: 0.02em;
    transform: translateY(20px);
    opacity: 0;
    animation: buttonFadeIn 0.5s forwards;
    animation-delay: calc(var(--i) * 0.15s + 0.7s);
  }
  
  @keyframes buttonFadeIn {
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  
  .lang-btn::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: all 0.6s ease;
  }
  
  .lang-btn:hover {
    transform: translateY(-4px) scale(1.05);
    box-shadow: 0 7px 20px rgba(0, 0, 0, 0.2);
  }
  
  .lang-btn:hover::before {
    left: 100%;
  }
  
  .lang-btn .flag {
    margin-right: 8px;
    opacity: 0.9;
    font-size: 1.2em;
  }
  
  .code-snippet {
    background: var(--code-bg);
    padding: 2rem;
    border-radius: 12px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.9rem;
    color: var(--text-color);
    text-align: left;
    margin: 2rem 0;
    position: relative;
    overflow: hidden;
    box-shadow: 0 4px 25px rgba(0, 0, 0, 0.2);
    border-left: 3px solid var(--accent-color);
    transition: all 0.3s ease;
    overflow-x: auto;
    width: 100%;
    max-width: 100%;
    box-sizing: border-box;
  }
  
  .code-snippet:hover {
    box-shadow: 0 6px 30px rgba(0, 0, 0, 0.3);
    transform: translateY(-2px);
  }

  .code-snippet::after {
    content: "";
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    width: 40px;
    background: linear-gradient(90deg, transparent, var(--code-bg));
    pointer-events: none;
    opacity: 0;
    transition: opacity 0.3s;
    z-index: auto;
  }

  .code-snippet.scrollable::after {
    opacity: 1;
  }
  
  .code-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    color: var(--accent-color);
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    padding-bottom: 0.8rem;
    font-weight: 500;
  }
  
  .code-header .filename {
    display: flex;
    align-items: center;
  }
  
  .code-header .filename:before {
    content: "📄";
    margin-right: 8px;
  }
  
  .code-header .language {
    background-color: rgba(var(--accent-color-rgb), 0.2);
    padding: 0.2rem 0.7rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    letter-spacing: 0.5px;
    color: var(--accent-color);
  }
  
  .line-numbers {
    position: absolute;
    left: 1rem;
    top: 6.05rem;
    padding: 0 10px;
    color: rgba(255, 255, 255, 0.3);
    user-select: none;
    text-align: right;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
    padding-right: 15px;
    font-family: 'JetBrains Mono', monospace;
    display: flex;
    flex-direction: column;
    line-height: 1.38;
    z-index: 1;
  }
  
  .code-content {
    margin-left: 45px;
    position: relative;
    line-height: 1.6;
    padding-top: 0;
    min-height: 100%;
    min-width: max-content;
  }
  
  .code-line {
    display: block;
    margin-bottom: 0; 
    white-space: pre;
    font-family: 'JetBrains Mono', monospace;
    opacity: 0;
    animation: typeIn 0.5s forwards;
    animation-delay: calc(var(--i, 0) * 0.1s);
    position: relative;
    z-index: 2;
  }
  
  @keyframes typeIn {
    from { opacity: 0; transform: translateX(-10px); }
    to { opacity: 1; transform: translateX(0); }
  }
  
  .theme-light .keyword { color: #d7008a; }
  .theme-light .string { color: #937200; }
  .theme-light .comment { color: #0057a6; }
  .theme-light .function { color: #007e23; }
  .theme-light .register { color: #6c00bd; }
  .theme-light .directive { color: #006f87; }
  
  .theme-dark .keyword, .keyword { color: #ff79c6; }
  .theme-dark .string, .string { color: #f1fa8c; }
  .theme-dark .comment, .comment { color: #6272a4; }
  .theme-dark .function, .function { color: #50fa7b; }
  .theme-dark .register, .register { color: #bd93f9; }
  .theme-dark .directive, .directive { color: #8be9fd; }
  
  .theme-light .line-numbers {
    color: rgba(0, 0, 0, 0.4);
    border-right-color: rgba(0, 0, 0, 0.15);
  }

  .footer-animation {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    height: 4px;
    overflow: hidden;
  }
  
  .footer-animation::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 200%;
    height: 100%;
    background: linear-gradient(90deg, 
      transparent, transparent, var(--accent-color), 
      var(--primary-color), var(--accent-color), 
      transparent, transparent);
    animation: lightSpeed 3s linear infinite;
  }
  
  @keyframes lightSpeed {
    0% { transform: translateX(0); }
    100% { transform: translateX(50%); }
  }

  @keyframes titlePressLeft {
    0% { transform: perspective(800px) rotateY(0) rotateX(0); }
    30% { transform: perspective(800px) rotateY(-15deg) rotateX(5deg) translateZ(-10px); }
    100% { transform: perspective(800px) rotateY(0) rotateX(0); }
  }
  
  @keyframes titlePressRight {
    0% { transform: perspective(800px) rotateY(0) rotateX(0); }
    30% { transform: perspective(800px) rotateY(15deg) rotateX(5deg) translateZ(-10px); }
    100% { transform: perspective(800px) rotateY(0) rotateX(0); }
  }
  
  @keyframes titlePressTop {
    0% { transform: perspective(800px) rotateY(0) rotateX(0); }
    30% { transform: perspective(800px) rotateY(0) rotateX(15deg) translateZ(-10px); }
    100% { transform: perspective(800px) rotateY(0) rotateX(0); }
  }
  
  @keyframes titlePressBottom {
    0% { transform: perspective(800px) rotateY(0) rotateX(0); }
    30% { transform: perspective(800px) rotateY(0) rotateX(-15deg) translateZ(-10px); }
    100% { transform: perspective(800px) rotateY(0) rotateX(0); }
  }
  
  @keyframes titlePressCenter {
    0% { transform: perspective(800px) scale3d(1, 1, 1); }
    30% { transform: perspective(800px) scale3d(0.95, 0.95, 0.95); }
    100% { transform: perspective(800px) scale3d(1, 1, 1); }
  }
  
  @media (max-width: 768px) {
    .main-content {
      padding: 1rem;
    }
    
    .card {
      padding: 1.5rem;
    }
    
    .md-typeset h1 {
      font-size: 3.2em;
      padding: 0.15em 0.2em;
      margin: 0 0 0 0;
    }
    
    .title::before {
      font-size: 2.2rem; 
      white-space: normal;
      word-break: keep-all;
      line-height: 1.2;
    }
    
    .subtitle {
      font-size: 1.1rem;
      margin-bottom: 2rem;
    }
    
    .code-snippet {
      padding: 1.5rem 1rem;
      font-size: 0.85rem;
    }
    
    .code-header {
      margin-bottom: 1.2rem;
      flex-wrap: wrap;
    }
    
    .code-header .language {
      margin-top: 0.5rem;
    }
    
    .line-numbers {
      left: 0.5rem;
      top: 6.8rem;
      padding-right: 10px;
      font-size: 0.8rem;
      line-height: 1.46;
    }
    
    .code-content {
      margin-left: 30px;
    }
    
    .lang-buttons {
      flex-direction: column;
      gap: 1rem;
    }
    
    .lang-btn {
      width: 100%;
    }
    
    .logo-container {
      width: 90px;
      height: 90px;
      margin: 0 auto 1.5rem;
      perspective: 900px; 
    }
    
    .logo-face {
      border-width: 1px;
    }
    
    .logo {
      transform-style: preserve-3d;
      animation: rotate3d-mobile 12s infinite ease-in-out;
    }
    
    .theme-dark .logo-front,
    .theme-light .logo-front {
      transform: translateZ(60px);
      font-size: 22px; 
    }
    
    .theme-dark .logo-back,
    .theme-light .logo-back {
      transform: rotateY(180deg) translateZ(60px);
      font-size: 22px; 
    }
    
    .theme-dark .logo-right,
    .theme-light .logo-right {
      transform: rotateY(90deg) translateZ(60px);
      font-size: 16px; 
    }
    
    .theme-dark .logo-left,
    .theme-light .logo-left {
      transform: rotateY(-90deg) translateZ(60px);
      font-size: 16px; 
    }
    
    .theme-dark .logo-top,
    .theme-light .logo-top {
      transform: rotateX(90deg) translateZ(60px);
      font-size: 18px; 
    }
    
    .theme-dark .logo-bottom,
    .theme-light .logo-bottom {
      transform: rotateX(-90deg) translateZ(60px);
      font-size: 18px; 
    }
    
    @keyframes rotate3d-mobile {
      0%, 100% { transform: rotateY(0deg) rotateX(0deg); }
      25% { transform: rotateY(60deg) rotateX(10deg); }
      50% { transform: rotateY(180deg) rotateX(0deg); }
      75% { transform: rotateY(240deg) rotateX(-10deg); }
    }
  }
  
  @media (max-width: 480px) {
    .logo-container {
      width: 80px;
      height: 80px;
      margin: 0 auto 1rem;
      perspective: 800px;
    }
    
    .title {
      font-size: 1.8rem;
    }
    
    .title::before {
      font-size: 1.8rem;
    }
    
    .code-snippet {
      margin: 1.5rem 0;
      padding: 1.2rem 0.8rem;
    }
    
    .line-numbers {
      font-size: 0.75rem;
      left: 0.3rem;
      padding-right: 8px;
    }
    
    .code-content {
      margin-left: 25px;
      font-size: 0.8rem;
    }
    
    .theme-dark .logo-front,
    .theme-light .logo-front,
    .theme-dark .logo-back,
    .theme-light .logo-back {
      transform: translateZ(40px);
      font-size: 18px;
    }
    
    .theme-dark .logo-right,
    .theme-light .logo-right,
    .theme-dark .logo-left,
    .theme-light .logo-left {
      transform: rotateY(90deg) translateZ(40px);
      font-size: 12px;
    }
    
    .theme-dark .logo-top,
    .theme-light .logo-top,
    .theme-dark .logo-bottom,
    .theme-light .logo-bottom {
      transform: rotateX(90deg) translateZ(40px);
      font-size: 14px;
    }
    

    .logo {
      animation: rotate3d-tiny 15s infinite ease-in-out;
    }
    
    @keyframes rotate3d-tiny {
      0%, 100% { transform: rotateY(0deg); }
      50% { transform: rotateY(180deg); }
    }
  }
  .low-performance-device .particle {
    display: none;
  }
  
  .low-performance-device .binary-rain {
    display: none;
  }
  
  .low-performance-device .matrix-code {
    display: none;
  }
  
  .low-performance-device .glow-effect {
    animation: none;
    opacity: 0.2;
  }
  
  .low-performance-device .logo {
    animation: rotate3d-simple 20s infinite linear;
  }
  
  @keyframes rotate3d-simple {
    0% { transform: rotateY(0deg); }
    100% { transform: rotateY(360deg); }
  }
</style>

<div class="particles" id="particles"></div>
<div class="binary-rain" id="binaryRain"></div>
<div class="matrix-code-container" id="matrixCode"></div>

<div class="main-content">
  <div class="card">
    <div class="circuit-overlay"></div>
    
    <div class="logo-container">
      <div class="glow-effect"></div>
      <div class="logo" id="themeLogo">
        <div class="logo-face logo-front">ASM</div>
        <div class="logo-face logo-back">x86</div>
        <div class="logo-face logo-right">0101</div>
        <div class="logo-face logo-left">1010</div>
        <div class="logo-face logo-top" title=":)">CPU</div>
        <div class="logo-face logo-bottom" title=":)">MOV</div>
      </div>
    </div>
    
    <h1 class="title" id="mainTitle"> 0000 </h1>
    <p class="subtitle">Dive into the world of low-level programming with our comprehensive guide to Assembly language</p>
    
    <div class="code-snippet">
      <div class="code-header">
        <span class="filename">hello_world.asm</span>
        <span class="language">x86 Assembly</span>
      </div>
      
      <div class="line-numbers">
        <span>1</span>
        <span>2</span>
        <span>3</span>
        <span>4</span>
        <span>5</span>
        <span>6</span>
        <span>7</span>
        <span>8</span>
        <span>9</span>
        <span>10</span>
        <span>11</span>
      </div>
      
      <div class="code-content">
        <code class="code-line" style="--i:0"><span class="directive">section</span> .data</code>
        <code class="code-line" style="--i:1">&nbsp;&nbsp;&nbsp;&nbsp;msg <span class="directive">db</span> <span class="string">"Hello, World!"</span>, 0x0A, 0</code>
        <code class="code-line" style="--i:2">&nbsp;&nbsp;&nbsp;&nbsp;len <span class="directive">equ</span> $ - msg</code>
        <code class="code-line" style="--i:3"><span class="directive">section</span> .text</code>
        <code class="code-line" style="--i:4">&nbsp;&nbsp;&nbsp;&nbsp;<span class="directive">global</span> <span class="function">_start</span></code>
        <code class="code-line" style="--i:5"><span class="function">_start:</span></code>
        <code class="code-line" style="--i:6">&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">mov</span> <span class="register">eax</span>, 4</code>
        <code class="code-line" style="--i:7">&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">mov</span> <span class="register">ebx</span>, 1</code>
        <code class="code-line" style="--i:8">&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">mov</span> <span class="register">ecx</span>, msg</code>
        <code class="code-line" style="--i:9">&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">mov</span> <span class="register">edx</span>, len</code>
        <code class="code-line" style="--i:10">&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">int</span> 0x80</code>
      </div>
    </div>
    
    <div class="loader-container">
      <div class="loader"></div>
    </div>
    
    <div class="language-selection">
      <p>Choose your preferred language:</p>
      <div class="lang-buttons">
        <a href="./en/" class="lang-btn" data-lang="en" style="--i:0">
          <span class="flag">🇺🇸</span> English
        </a>
        <a href="./ru/" class="lang-btn" data-lang="ru" style="--i:1">
          <span class="flag">🇷🇺</span> Русский
        </a>
      </div>
    </div>
  </div>
</div>

<div class="footer-animation"></div>

<script>
  window.giscusDisabled = true;
  
  
  function detectLowPerformanceDevice() {
    
    const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
    
    
    const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
    
    
    let lowRAM = false;
    if (navigator.deviceMemory) {
      lowRAM = navigator.deviceMemory < 4; 
    }
    
    
    let lowCPU = false;
    if (navigator.hardwareConcurrency) {
      lowCPU = navigator.hardwareConcurrency <= 4; 
    }
    
    
    return (isMobile && (isIOS || lowRAM || lowCPU));
  }
  
  function applyPerformanceOptimizations() {
    if (detectLowPerformanceDevice()) {
      document.body.classList.add('low-performance-device');
      
      
      const particlesContainer = document.getElementById('particles');
      if (particlesContainer) {
        particlesContainer.style.display = 'none';
      }
      
      const binaryRain = document.getElementById('binaryRain');
      if (binaryRain) {
        binaryRain.style.display = 'none';
      }
      
      const matrixCode = document.getElementById('matrixCode');
      if (matrixCode) {
        matrixCode.style.display = 'none';
      }
      
      
      document.querySelectorAll('.code-line').forEach(line => {
        line.style.opacity = '1';
        line.style.transform = 'translateX(0)';
        line.style.animation = 'none';
      });
    }
  }
  
  function createParticles() {
    const particlesContainer = document.getElementById('particles');
    
    const isMobile = window.innerWidth <= 768;
    const particleCount = isMobile ? Math.min(30, Math.floor(window.innerWidth / 30)) : Math.min(100, Math.floor(window.innerWidth / 20));
    
    
    if (detectLowPerformanceDevice()) {
      return;
    }
    
    for (let i = 0; i < particleCount; i++) {
      const particle = document.createElement('div');
      particle.classList.add('particle');
      
      const x = Math.random() * 100;
      const y = Math.random() * 100;
      particle.style.left = `${x}%`;
      particle.style.top = `${y}%`;
      
      const size = Math.random() * 3 + 1;
      particle.style.width = `${size}px`;
      particle.style.height = `${size}px`;
      
      const duration = Math.random() * 20 + 10;
      particle.style.animationDuration = `${duration}s`;
      
      const delay = Math.random() * 5;
      particle.style.animationDelay = `${delay}s`;
      
      particlesContainer.appendChild(particle);
    }
  }
  
  function createBinaryRain() {
    
    if (detectLowPerformanceDevice()) {
      return;
    }
    
    const container = document.getElementById('binaryRain');
    
    const isMobile = window.innerWidth <= 768;
    const columnCount = isMobile ? Math.floor(window.innerWidth / 80) : Math.floor(window.innerWidth / 40);
    
    for (let i = 0; i < columnCount; i++) {
      const column = document.createElement('div');
      column.classList.add('binary-column');
      
      column.style.left = `${Math.random() * 100}%`;
      
      const duration = Math.random() * 20 + 15;
      column.style.animationDuration = `${duration}s`;
      
      const delay = Math.random() * 10;
      column.style.animationDelay = `${delay}s`;
      
      let content = '';
      
      const length = isMobile ? Math.floor(Math.random() * 10 + 5) : Math.floor(Math.random() * 20 + 10);
      for (let j = 0; j < length; j++) {
        content += Math.random() > 0.5 ? '1' : '0';
        content += '<br>';
      }
      column.innerHTML = content;
      
      container.appendChild(column);
    }
  }
  
  function createMatrixEffect() {
    
    if (detectLowPerformanceDevice()) {
      return;
    }
    
    const container = document.getElementById('matrixCode');
    
    const isMobile = window.innerWidth <= 768;
    const columnCount = isMobile ? 5 : 20;
    
    const assemblySnippets = [
      'MOV EAX, 1', 'XOR EDX, EDX', 'PUSH EBP',
      'INT 0x80', 'CMP EAX, 0', 'JMP label',
      'ADD ESP, 4', 'RET', 'CALL func',
      'LEA ECX, [EBX+4]', 'SHL EAX, 2', 'AND EAX, 0xFF'
    ];
    
    for (let i = 0; i < columnCount; i++) {
      const column = document.createElement('div');
      column.classList.add('matrix-code');
      
      column.style.left = `${Math.random() * 100}%`;
      
      const duration = Math.random() * 15 + 10;
      column.style.animationDuration = `${duration}s`;
      
      const delay = Math.random() * 10;
      column.style.animationDelay = `${delay}s`;
      
      let content = '';
      const length = Math.floor(Math.random() * 15 + 5);
      for (let j = 0; j < length; j++) {
        if (Math.random() > 0.7) {
          content += assemblySnippets[Math.floor(Math.random() * assemblySnippets.length)];
        } else {
          const hexAddr = (Math.random() * 0xFFFFFFFF).toString(16).padStart(8, '0').toUpperCase();
          content += `0x${hexAddr}`;
        }
        content += '<br>';
      }
      column.innerHTML = content;
      
      container.appendChild(column);
    }
  }
  
  const SUPPORTED_LANGUAGES = ["en", "ru"];
  
  function shouldSkipRedirect() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.has('no-redirect') && urlParams.get('no-redirect') === 'true';
  }
  
  function detectLanguageAndRedirect() {
    if (shouldSkipRedirect()) {
      document.querySelector('.loader-container').style.display = 'none';
      return;
    }
    
    const browserLang = (navigator.language || navigator.userLanguage || "").toLowerCase();
    let matchedLang = null;
    
    for (const lang of SUPPORTED_LANGUAGES) {
      if (browserLang === lang || browserLang.startsWith(lang + "-")) {
        matchedLang = lang;
        break;
      }
    }
    
    if (!matchedLang) matchedLang = "en";
    
    setTimeout(() => {
      window.giscusDisabled = false;
      window.location.href = `./${matchedLang}/`;
    }, 3500);
  }
  
  function initTheme() {
    if (window.ThemeManager) {
      const theme = window.ThemeManager.getTheme();
      applyThemeColors(theme === 'dark');
      
      window.ThemeManager.onThemeChange(function(theme) {
        applyThemeColors(theme === 'dark');
      });
    } else {
      const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
      applyThemeColors(prefersDark);
      
      const darkModeMediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
      if (darkModeMediaQuery.addEventListener) {
        darkModeMediaQuery.addEventListener('change', (e) => applyThemeColors(e.matches));
      }
    }
  }
  
  function applyThemeColors(isDark) {
    const root = document.documentElement;
    
    if (isDark) {
      root.style.setProperty('--bg-color', '#070014');
      root.style.setProperty('--primary-color', '#16002b');
      root.style.setProperty('--accent-color', 'rgba(255, 140, 0, 0.9)');
      root.style.setProperty('--text-color', '#f0f0f0');
      root.style.setProperty('--button-bg', '#2a0049');
      root.style.setProperty('--button-hover-bg', '#3b006b');
      root.style.setProperty('--card-bg', 'rgba(25, 0, 40, 0.7)');
      root.style.setProperty('--code-bg', 'rgba(30, 0, 60, 0.6)');
      root.style.setProperty('--primary-color-rgb', '22, 0, 43');
      root.style.setProperty('--accent-color-rgb', '255, 140, 0');
      
      
      document.querySelector('.code-snippet')?.classList.remove('theme-light');
      document.querySelector('.code-snippet')?.classList.add('theme-dark');
    } else {
      root.style.setProperty('--bg-color', '#f2f6ff');
      root.style.setProperty('--primary-color', '#98c1ff');
      root.style.setProperty('--accent-color', 'rgba(55, 125, 135, 0.95)');
      root.style.setProperty('--text-color', '#2c2c2c');
      root.style.setProperty('--button-bg', '#cce0ff');
      root.style.setProperty('--button-hover-bg', '#b1d0ff');
      root.style.setProperty('--card-bg', 'rgba(255, 255, 255, 0.5)');
      root.style.setProperty('--code-bg', 'rgba(240, 245, 255, 0.7)');
      root.style.setProperty('--primary-color-rgb', '152, 193, 255');
      root.style.setProperty('--accent-color-rgb', '55, 125, 135');
      
      
      document.querySelector('.code-snippet')?.classList.remove('theme-dark');
      document.querySelector('.code-snippet')?.classList.add('theme-light');
    }
    
    
    updateLogoTheme(isDark ? 'dark' : 'light');
  }
  
  function handleThemeToggle() {
    const currentTheme = window.ThemeManager ? window.ThemeManager.getTheme() : 
      (document.documentElement.getAttribute('data-theme') || 
      (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'));
    
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    if (window.ThemeManager) {
      window.ThemeManager.setTheme(newTheme);
      
      try {
        const palette = JSON.parse(localStorage.getItem('__palette')) || {};
        palette.index = newTheme === 'dark' ? 0 : 1;
        localStorage.setItem('__palette', JSON.stringify(palette));
        
        document.body.setAttribute('data-md-color-scheme', newTheme === 'dark' ? 'slate' : 'default');
        
        if (typeof __md_get !== 'undefined') {
          __md_get('__palette', localStorage.getItem('__palette')).then(function() {});
        }
      } catch (e) {
        console.error('Ошибка при изменении темы через MkDocs API:', e);
      }
    } else {
      document.documentElement.setAttribute('data-theme', newTheme);
      localStorage.setItem('theme', newTheme);
      applyThemeColors(newTheme === 'dark');
    }
  }
  
  function updateLogoTheme(theme) {
    const container = document.querySelector('.logo-container');
    if (container) {
      if (theme === 'dark') {
        container.classList.remove('theme-light');
        container.classList.add('theme-dark');
      } else {
        container.classList.remove('theme-dark');
        container.classList.add('theme-light');
      }
    }
  }
  
  function initVisualEffects() {
    createParticles();
    createBinaryRain();
    createMatrixEffect();
  }
  
  document.addEventListener('DOMContentLoaded', function() {
    initVisualEffects();
    initTheme();
    detectLanguageAndRedirect();
    
    
    const currentTheme = window.ThemeManager ? window.ThemeManager.getTheme() : 
      (document.documentElement.getAttribute('data-theme') || 
      (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'));
    
    document.querySelector('.code-snippet').classList.add(`theme-${currentTheme}`);
    
    
    setTimeout(() => {
      const codeLines = document.querySelectorAll('.code-line');
      codeLines.forEach(line => {
        if (getComputedStyle(line).display === 'none' || line.offsetHeight === 0) {
          line.style.display = 'block';
          line.style.opacity = '1';
        }
      });
    }, 1000);
    
    const themeToggle = document.getElementById('themeToggle');
    if (themeToggle) {
      themeToggle.addEventListener('click', handleThemeToggle);
    }
    
    const langButtons = document.querySelectorAll('.lang-btn');
    langButtons.forEach((button) => {
      button.addEventListener('mouseenter', function() {
        this.querySelector('.flag').style.transform = 'scale(1.2) rotate(5deg)';
      });
      
      button.addEventListener('mouseleave', function() {
        this.querySelector('.flag').style.transform = 'scale(1) rotate(0)';
      });
    });
  });
  
  window.addEventListener('load', function() {
    if (shouldSkipRedirect()) {
      document.querySelector('.loader-container').style.display = 'none';
    }
    
    
    applyPerformanceOptimizations();
    
    
    applyDeviceSpecificCubeStyles();
    
    if (typeof anime !== 'undefined' && !detectLowPerformanceDevice()) {
      anime({
        targets: '.logo',
        rotateY: [0, 360],
        duration: 4000,
        easing: 'easeInOutQuad',
        loop: true
      });
      
      anime({
        targets: '.glow-effect',
        scale: [0.8, 1.2],
        opacity: [0.2, 0.4, 0.2],
        duration: 3000,
        easing: 'easeInOutSine',
        loop: true
      });
      
      anime({
        targets: '.particle',
        translateY: function() { return [-50, anime.random(-200, -100)]; },
        translateX: function() { return [anime.random(-10, 10), anime.random(-20, 20)]; },
        opacity: [0, 0.8, 0],
        easing: 'easeOutExpo',
        duration: function() { return anime.random(8000, 15000); },
        delay: function() { return anime.random(0, 2000); },
        loop: true
      });
    }
    
    
    animateCodeLines();
    
    
    checkCodeOverflow();
    
    
    window.addEventListener('resize', function() {
      checkCodeOverflow();
      applyDeviceSpecificCubeStyles();
    });
  });
  
  
  function applyDeviceSpecificCubeStyles() {
    const logoContainer = document.querySelector('.logo-container');
    const logo = document.querySelector('.logo');
    const faces = document.querySelectorAll('.logo-face');
    
    if (!logoContainer || !logo) return;
    
    const isMobile = window.innerWidth <= 768;
    const isSmallMobile = window.innerWidth <= 480;
    const isLowPerformanceDevice = detectLowPerformanceDevice();
    
    
    if (isLowPerformanceDevice) {
      logo.style.animation = 'rotate3d-simple 20s infinite linear';
    } else if (isSmallMobile) {
      logo.style.animation = 'rotate3d-tiny 15s infinite ease-in-out';
    } else if (isMobile) {
      logo.style.animation = 'rotate3d-mobile 12s infinite ease-in-out';
    } else {
      logo.style.animation = 'rotate3d 8s infinite ease-in-out';
    }
    
    
    if (isSmallMobile) {
      faces.forEach(face => {
        if (face.classList.contains('logo-front') || face.classList.contains('logo-back')) {
          face.style.transform = face.classList.contains('logo-back') 
            ? 'rotateY(180deg) translateZ(40px)' 
            : 'translateZ(40px)';
          face.style.fontSize = '18px';
        } else if (face.classList.contains('logo-top') || face.classList.contains('logo-bottom')) {
          face.style.transform = face.classList.contains('logo-bottom') 
            ? 'rotateX(-90deg) translateZ(40px)' 
            : 'rotateX(90deg) translateZ(40px)';
          face.style.fontSize = '14px';
        } else {
          face.style.transform = face.classList.contains('logo-left') 
            ? 'rotateY(-90deg) translateZ(40px)' 
            : 'rotateY(90deg) translateZ(40px)';
          face.style.fontSize = '12px';
        }
      });
    } else if (isMobile) {
      faces.forEach(face => {
        if (face.classList.contains('logo-front') || face.classList.contains('logo-back')) {
          face.style.transform = face.classList.contains('logo-back') 
            ? 'rotateY(180deg) translateZ(60px)' 
            : 'translateZ(60px)';
          face.style.fontSize = '22px';
        } else if (face.classList.contains('logo-top') || face.classList.contains('logo-bottom')) {
          face.style.transform = face.classList.contains('logo-bottom') 
            ? 'rotateX(-90deg) translateZ(60px)' 
            : 'rotateX(90deg) translateZ(60px)';
          face.style.fontSize = '18px';
        } else {
          face.style.transform = face.classList.contains('logo-left') 
            ? 'rotateY(-90deg) translateZ(60px)' 
            : 'rotateY(90deg) translateZ(60px)';
          face.style.fontSize = '16px';
        }
      });
    }
  }

  document.addEventListener('DOMContentLoaded', function() {
    const title = document.getElementById('mainTitle');
    const themeLogo = document.getElementById('themeLogo');
    
    
    if (!detectLowPerformanceDevice() && typeof anime !== 'undefined') {
      
      setTimeout(() => {
        anime({
          targets: '.logo',
          scale: [0.2, 1],
          opacity: [0, 1],
          rotateY: [90, 0],
          duration: 1800,
          easing: 'easeOutElastic(1, .4)',
          complete: function() {
            if (!detectLowPerformanceDevice()) {
              anime({
                targets: '.logo',
                rotateY: [0, 360],
                duration: 6000,
                easing: 'easeInOutQuad',
                loop: true
              });
            }
          }
        });
      }, 500);
    } else {
      
      document.querySelector('.logo').style.opacity = '1';
    }
    
    
    const logoTop = document.querySelector('.logo-top');
    const logoBottom = document.querySelector('.logo-bottom');
    
    if (logoTop) {
      logoTop.addEventListener('click', function() {
        const messages = [
          'Hello from CPU!',
          'SIMD operations rule!',
          'You found the secret!',
          'x86-64 > ARM'
        ];
        alert(messages[Math.floor(Math.random() * messages.length)]);
      });
    }
    
    if (logoBottom) {
      logoBottom.addEventListener('click', function() {
        const messages = [
          'MOV - best instruction!',
          'Assembly loves you',
          'PUSH/POP forever',
          'Registers are my friends'
        ];
        alert(messages[Math.floor(Math.random() * messages.length)]);
      });
    }
    
    
    if (themeLogo) {
      
      themeLogo.title = "3D Assembly Cube";
    }
    
    title.addEventListener('click', function(e) {
      const rect = this.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      
      const width = rect.width;
      const height = rect.height;
      
      this.style.animation = 'none';
      void this.offsetWidth;
      
      if (x < width * 0.3) {
        this.style.animation = 'titlePressLeft 0.8s cubic-bezier(0.22, 1, 0.36, 1)';
      } else if (x > width * 0.7) {
        this.style.animation = 'titlePressRight 0.8s cubic-bezier(0.22, 1, 0.36, 1)';
      } else if (y < height * 0.3) {
        this.style.animation = 'titlePressTop 0.8s cubic-bezier(0.22, 1, 0.36, 1)';
      } else if (y > height * 0.7) {
        this.style.animation = 'titlePressBottom 0.8s cubic-bezier(0.22, 1, 0.36, 1)';
      } else {
        this.style.animation = 'titlePressCenter 0.8s cubic-bezier(0.22, 1, 0.36, 1)';
      }
    });
    
    
    if('MutationObserver' in window) {
      const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
          if (mutation.type === 'attributes' && 
              (mutation.attributeName === 'data-md-color-scheme' || 
               mutation.attributeName === 'data-theme')) {
            
            const isDark = document.body.getAttribute('data-md-color-scheme') === 'slate' || 
                          document.documentElement.getAttribute('data-theme') === 'dark';
                          
            applyThemeColors(isDark);
          }
        });
      });
      
      observer.observe(document.body, { attributes: true });
      observer.observe(document.documentElement, { attributes: true });
    }
    
    
    const currentTheme = window.ThemeManager ? window.ThemeManager.getTheme() : 
      (document.documentElement.getAttribute('data-theme') || 
       (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'));
       
    updateLogoTheme(currentTheme);
    
    
    setTimeout(applyDeviceSpecificCubeStyles, 100);
    
    
    setTimeout(checkCodeOverflow, 500);
  });

  
  function animateCodeLines() {
    const codeLines = document.querySelectorAll('.code-line');
    const isLowPerformanceDevice = detectLowPerformanceDevice();
    
    codeLines.forEach((line, index) => {
      line.style.setProperty('--i', index);
      
      
      if (isLowPerformanceDevice) {
        line.style.opacity = '1';
        line.style.transform = 'translateX(0)';
        line.style.animation = 'none';
      } else {
        
        setTimeout(() => {
          if (parseFloat(getComputedStyle(line).opacity) < 0.5) {
            line.style.opacity = '1';
            line.style.transform = 'translateX(0)';
          }
        }, 1000 + index * 100);
      }
    });
  }

  
  function checkCodeOverflow() {
    const codeSnippet = document.querySelector('.code-snippet');
    if (codeSnippet) {
      const codeContent = codeSnippet.querySelector('.code-content');
      if (codeContent && codeContent.scrollWidth > codeSnippet.clientWidth) {
        codeSnippet.classList.add('scrollable');
      } else {
        codeSnippet.classList.remove('scrollable');
      }
    }
  }
</script>