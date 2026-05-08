<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NeSL | Secure Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body class="login-page">

    <!-- ── HEADER ── -->
    <header class="header">
        <div class="logo-wrap">
            <div class="logo-mark">Ne<span class="accent-sl">SL<sup>®</sup></span></div>
            <div class="logo-divider"></div>
            <div class="logo-tagline">National E-Governance<br>Services Limited</div>
        </div>
        <div class="header-badge">
            <span class="badge-dot"></span>
            <span class="badge-txt">Secure Access</span>
        </div>
    </header>

    <!-- ── MAIN ── -->
    <main class="main">
        <div class="card">
            <div class="card-stripe"></div>
            <div class="card-body">

                <div class="section-head">
                    <div class="locale-switcher">
                        <label for="localeSelect">Language</label>
                        <select id="localeSelect" onchange="switchLanguage()">
                            <option value="en">English</option>
                            <option value="hi">हिंदी</option>
                        </select>
                    </div>
                    <h1 id="pageHeading">Welcome</h1>
                    <p id="pageSubhead">Sign in to continue to your NeSL account</p>
                </div>

                <form id="authForm" method="POST" action="${pageContext.request.contextPath}/perform_login" novalidate>
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />

                    <!-- Login Category -->
                    <div class="form-group">
                        <div class="field-label" id="loginCategoryLabel"><span id="loginCategoryLabelText">Login Category</span> <span class="req">*</span></div>
                        <div class="input-shell">
                            <div class="input-icon">&#9783;</div>
                            <select id="loginType" name="loginType" onchange="toggleForm()" required>
                                <option value="">— Select Category —</option>
                                <option value="ENTITY">Entity User</option>
                                <option value="IRP">IRP / RP / Liquidator</option>
                                <option value="INDIVIDUAL">Individual User</option>
                                <option value="GOVT">Statutory / Govt Entity</option>
                                <option value="AOP">Association of Persons</option>
                            </select>
                        </div>
                    </div>

                    <!-- UIN / PAN -->
                    <div class="form-group hidden" id="uinWrap">
                        <div class="field-label" id="uinLabel">
                            <span id="uinLabelText">UIN (PAN)</span> <span class="req">*</span>
                            <span class="badge-pill">Entity Format</span>
                        </div>
                        <div class="input-shell" id="uinShell">
                            <div class="input-icon">&#127358;</div>
                            <input type="text" id="uinInput" name="uin" maxlength="10"
                                   placeholder="e.g. ABCDE1234F" autocomplete="off">
                            <span class="input-action" id="uinCheckIcon" style="display:none; font-size:18px;"></span>
                        </div>
                        <div class="pan-progress" id="panProgress">
                            <div class="pan-track"><div class="pan-fill" id="panFill"></div></div>
                            <div class="pan-hint" id="panHint">Enter 10-character PAN</div>
                        </div>
                        <div class="field-msg" id="uinMsg"></div>
                    </div>

                    <!-- User ID -->
                    <div class="form-group" id="userIdWrap">
                        <div class="field-label"><span id="lblOne">User ID</span> <span class="req">*</span></div>
                        <div class="input-shell">
                            <div class="input-icon">&#128100;</div>
                            <input type="text" id="idInput" name="userId"
                                   placeholder="Enter user ID" required autocomplete="username">
                            <button type="button" id="otpBtn" class="otp-btn" onclick="sendOtp()" style="display:none;">Send OTP</button>
                        </div>
                    </div>

                    <!-- Password / OTP -->
                    <div class="form-group">
                        <div class="field-label"><span id="lblTwo">Password</span> <span class="req">*</span></div>
                        <div class="input-shell">
                            <div class="input-icon">&#128274;</div>
                            <input type="password" id="passInput" name="password"
                                   placeholder="Enter password" required autocomplete="current-password">
                            <span class="input-action" id="eyeBtn" onclick="togglePassword()" title="Show/Hide">&#128065;</span>
                        </div>
                    </div>

                    <!-- CAPTCHA -->
                    <div class="form-group">
                        <div class="field-label" id="captchaLabel"><span id="captchaLabelText">Verification Code</span> <span class="req">*</span></div>
                        <div class="captcha-row">
                            <div class="input-shell">
                                <div class="input-icon">&#128272;</div>
                                <input type="text" id="captchaInput" name="captcha"
                                       placeholder="Enter code" maxlength="5" required autocomplete="off">
                            </div>
                            <div class="captcha-display" id="captchaDisplay">3N5K9</div>
                            <span class="captcha-refresh" onclick="refreshCaptcha()" title="Refresh">&#8635;</span>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="actions">
                        <button type="submit" class="btn-signin">Sign In &rarr;</button>
                    </div>

                    <div class="divider"><span>or continue with</span></div>

                    <div class="social-login">
                        <a class="btn-google" href="${pageContext.request.contextPath}/oauth2/authorization/google">
                            <svg class="btn-google-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                                <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                                <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                                <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                            </svg>
                            <span class="btn-google-text">Sign in with Google</span>
                        </a>
                    </div>
                    
                    <div style="text-align: center; margin-top: 18px;">
                        <a href="#" id="forgotBtn" class="forgot-link">Forgot your password?</a>
                    </div>

                </form>
            </div>
            <footer class="card-footer">
                    <div class="reg-row">
                        <span class="reg-label">New Entity?</span>
                        <a href="#" class="reg-link">Register Now &rsaquo;</a>
                    </div>
                    <div class="reg-row">
                        <span class="reg-label">New Individual?</span>
                        <a href="#" class="reg-link">Register Now &rsaquo;</a>
                    </div>
                    <a href="#" class="help-link">&#128222; &nbsp;Contact Help Desk</a>
            </footer>

            <script>
                const translations = {
                    en: {
                        heading: 'Welcome',
                        subhead: 'Sign in to continue to your NeSL account',
                        loginCategory: 'Login Category',
                        uinLabel: 'UIN (PAN)',
                        userId: 'User ID',
                        password: 'Password',
                        captcha: 'Verification Code',
                        signIn: 'Sign In →',
                        forgot: 'Forgot your password?',
                        orContinue: 'or continue with',
                        google: 'Sign in with Google'
                    },
                    hi: {
                        heading: 'स्वागत है',
                        subhead: 'अपने NeSL खाते में साइन इन करें',
                        loginCategory: 'लॉगिन श्रेणी',
                        uinLabel: 'यूआईएन (PAN)',
                        userId: 'उपयोगकर्ता आईडी',
                        password: 'पासवर्ड',
                        captcha: 'सत्यापन कोड',
                        signIn: 'साइन इन करें →',
                        forgot: 'क्या आपने पासवर्ड भूल गए?',
                        orContinue: 'या इस के साथ जारी रखें',
                        google: 'Google से साइन इन करें'
                    }
                };

                function switchLanguage() {
                    const locale = document.getElementById('localeSelect').value;
                    const text = translations[locale] || translations.en;

                    document.getElementById('pageHeading').textContent = text.heading;
                    document.getElementById('pageSubhead').textContent = text.subhead;
                    document.getElementById('loginCategoryLabelText').textContent = text.loginCategory;
                    document.getElementById('uinLabelText').textContent = text.uinLabel;
                    document.getElementById('lblOne').textContent = text.userId;
                    document.getElementById('lblTwo').textContent = text.password;
                    document.getElementById('captchaLabelText').textContent = text.captcha;
                    document.querySelector('.btn-signin').textContent = text.signIn;
                    document.querySelector('.forgot-link').textContent = text.forgot;
                    document.querySelector('.divider span').textContent = text.orContinue;
                    document.querySelector('.btn-google-text').textContent = text.google;
                }

                document.addEventListener('DOMContentLoaded', () => {
                    const locale = document.getElementById('localeSelect').value;
                    if (locale) { switchLanguage(); }
                });
            </script>
        </div>
    </main>

    <footer class="page-footer">
        &copy; 2025 National E-Governance Services Limited &mdash; All rights reserved
    </footer>

    <script>
        /* ─── ELEMENTS ─── */
        const uinInput   = document.getElementById('uinInput');
        const uinShell   = document.getElementById('uinShell');
        const uinMsg     = document.getElementById('uinMsg');
        const uinCheck   = document.getElementById('uinCheckIcon');
        const panProgress= document.getElementById('panProgress');
        const panFill    = document.getElementById('panFill');
        const panHint    = document.getElementById('panHint');
        const passInput  = document.getElementById('passInput');

        /* ─── TOGGLE FORM ─── */
        function toggleForm() {
            const val     = document.getElementById('loginType').value;
            const uinWrap = document.getElementById('uinWrap');
            const otpBtn  = document.getElementById('otpBtn');
            const forgotBtn= document.getElementById('forgotBtn');
            const lblOne  = document.getElementById('lblOne');
            const lblTwo  = document.getElementById('lblTwo');
            const idInput = document.getElementById('idInput');
            const eyeBtn  = document.getElementById('eyeBtn');

            /* defaults */
            uinWrap.classList.add('hidden');
            otpBtn.style.display   = 'none';
            forgotBtn.style.display= 'block';
            lblOne.innerText       = 'User ID';
            lblTwo.innerText       = 'Password';
            idInput.placeholder    = 'Enter user ID';
            passInput.type         = 'password';
            eyeBtn.style.display   = 'inline';
            clearUinState();

            if (val === 'ENTITY' || val === 'IRP' || val === 'GOVT' || val === 'AOP') {
                uinWrap.classList.remove('hidden');
            } else if (val === 'INDIVIDUAL') {
                otpBtn.style.display   = 'inline-block';
                forgotBtn.style.display= 'none';
                lblOne.innerText       = 'User ID (PAN / ID)';
                lblTwo.innerText       = 'OTP';
                idInput.placeholder    = 'Enter PAN or other ID';
                passInput.type         = 'text';
                passInput.placeholder  = 'Enter OTP';
                eyeBtn.style.display   = 'none';
            }
        }

        /* ─── PAN VALIDATION ─── */
        const PAN_REGEX = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
        const PAN_STATUS_LETTERS = ['P','C','H','F','A','T','B','L','J','G'];

        function clearUinState() {
            uinShell.classList.remove('error','success');
            uinMsg.className       = 'field-msg';
            uinMsg.innerText       = '';
            uinCheck.style.display = 'none';
            panProgress.style.display = 'none';
            panFill.style.width    = '0';
            uinInput.value         = '';
        }

        function getPanSegmentError(val) {
            if (val.length === 0) return null;
            const seg1 = val.substring(0, Math.min(val.length, 5));
            if (/[0-9]/.test(seg1))
                return 'First 5 characters must be letters (A–Z).';
            if (val.length > 3 && !PAN_STATUS_LETTERS.includes(val.charAt(3)))
                return '4th letter must be one of P, C, H, F, A, T, B, L, J, G for PAN status holder.';
            if (val.length > 5) {
                const seg2 = val.substring(5, Math.min(val.length, 9));
                if (!/^\d+$/.test(seg2))
                    return 'Characters 6–9 must be digits (0–9).';
            }
            if (val.length === 10 && /[0-9]/.test(val.charAt(9)))
                return '10th character must be a letter (A–Z).';
            return null;
        }

        function getPanProgress(val) {
            const len = val.length;
            if (len === 0)  return { pct: 0, color: '#e0e0e0', hint: 'Enter 10-character PAN' };
            if (len < 4)    return { pct: (len/10)*100, color: '#e67e22', hint: `${5-len} more letter(s) for segment 1` };
            if (len === 4)  return { pct: 40, color: '#f1c40f', hint: '4th letter indicates PAN holder status: P,C,H,F,A,T,B,L,J,G' };
            if (len < 9)    return { pct: (len/10)*100, color: '#f1c40f', hint: `${9-len} more digit(s) for segment 2` };
            if (len < 10)   return { pct: 90, color: '#f1c40f', hint: '1 more letter to complete PAN' };
            return PAN_REGEX.test(val)
                ? { pct: 100, color: '#2d8653', hint: '✓ Valid PAN format' }
                : { pct: 100, color: '#e63027', hint: 'Invalid PAN format' };
        }

        uinInput.addEventListener('input', function () {
            this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '');
            const val = this.value;

            panProgress.style.display = val.length > 0 ? 'block' : 'none';

            const prog = getPanProgress(val);
            panFill.style.width      = prog.pct + '%';
            panFill.style.background = prog.color;
            panHint.innerText        = prog.hint;

            const segErr = getPanSegmentError(val);

            if (segErr) {
                uinShell.classList.add('error'); uinShell.classList.remove('success');
                uinMsg.className  = 'field-msg error-msg';
                uinMsg.innerHTML  = '&#9888; ' + segErr;
                uinCheck.innerText= ''; uinCheck.style.display = 'none';
            } else if (val.length === 10 && PAN_REGEX.test(val)) {
                uinShell.classList.add('success'); uinShell.classList.remove('error');
                uinMsg.className  = 'field-msg success-msg';
                uinMsg.innerHTML  = '&#10003; Valid PAN format';
                uinCheck.innerText= '✓'; uinCheck.style.color = '#2d8653'; uinCheck.style.display = 'inline';
            } else {
                uinShell.classList.remove('error','success');
                uinMsg.className  = 'field-msg';
                uinMsg.innerText  = '';
                uinCheck.style.display = 'none';
            }
        });

        /* ─── PASSWORD TOGGLE ─── */
        function togglePassword() {
            passInput.type = passInput.type === 'password' ? 'text' : 'password';
        }

        /* ─── OTP ─── */
        function sendOtp() {
            const id = document.getElementById('idInput').value.trim();
            if (!id) { alert('Please enter your User ID first.'); return; }
            alert('OTP sent to registered mobile/email.');
        }

        /* ─── CAPTCHA ─── */
        function refreshCaptcha() {
            const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
            let code = '';
            for (let i = 0; i < 5; i++) code += chars[Math.floor(Math.random() * chars.length)];
            document.getElementById('captchaDisplay').innerText = code;
        }

        /* ─── SUBMIT ─── */
        document.getElementById('authForm').addEventListener('submit', function (e) {
            const val = document.getElementById('loginType').value;
            if (!val) { e.preventDefault(); alert('Please select a login category.'); return; }

            if (val === 'ENTITY' || val === 'GOVT' || val === 'AOP' || val === 'IRP') {
                const panValue = uinInput.value;
                const hasValidFourth = PAN_STATUS_LETTERS.includes(panValue.charAt(3));
                if (!PAN_REGEX.test(panValue) || !hasValidFourth) {
                    e.preventDefault();
                    uinShell.classList.add('error');
                    uinMsg.className = 'field-msg error-msg';
                    uinMsg.innerHTML = '&#9888; Valid PAN required: 5 letters + 4 digits + 1 letter, with 4th letter in P,C,H,F,A,T,B,L,J,G.';
                    uinInput.focus();
                    return;
                }
            }
        });

        /* ─── INIT ─── */
        window.onload = function () { toggleForm(); refreshCaptcha(); };
    </script>
</body>
</html>
