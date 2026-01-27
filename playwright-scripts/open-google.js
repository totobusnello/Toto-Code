// Ativa global-agent para proxy Node.js
require('global-agent/bootstrap');

const { chromium } = require('playwright');
const path = require('path');

(async () => {
  console.log('Abrindo o navegador...');

  // Usa o proxy do ambiente se disponível
  const proxyServer = process.env.HTTP_PROXY || process.env.http_proxy;
  console.log('Proxy configurado:', proxyServer ? 'Sim' : 'Não');

  // Inicia o navegador em modo visível (não headless)
  const launchOptions = {
    headless: false,
    slowMo: 500, // Adiciona pequeno delay para visualização
    args: []
  };

  // Adiciona proxy se disponível
  if (proxyServer) {
    // Extrai host:port do proxy URL
    const proxyUrl = new URL(proxyServer);
    const proxyHost = `${proxyUrl.hostname}:${proxyUrl.port}`;
    console.log('Proxy host:', proxyHost);

    // Configura proxy com autenticação via Playwright
    launchOptions.proxy = {
      server: `http://${proxyHost}`,
      username: decodeURIComponent(proxyUrl.username),
      password: decodeURIComponent(proxyUrl.password)
    };
    console.log('Username:', launchOptions.proxy.username.substring(0, 30) + '...');
  }

  const browser = await chromium.launch(launchOptions);

  // Cria uma nova página
  const page = await browser.newPage();

  // Navega para o Google (HTTP funciona com o proxy)
  console.log('Navegando para http://google.com...');
  try {
    await page.goto('http://google.com', { timeout: 30000 });
    await page.waitForLoadState('domcontentloaded');
    console.log('Google aberto com sucesso!');
    console.log('Título da página:', await page.title());
    console.log('URL atual:', page.url());

    // Tenta tirar um screenshot
    try {
      const screenshotPath = path.join(__dirname, 'screenshot.png');
      await page.screenshot({ path: screenshotPath, fullPage: false, timeout: 15000 });
      console.log(`Screenshot salvo em: ${screenshotPath}`);
    } catch (e) {
      console.log('Screenshot falhou (normal em ambiente headless)');
    }
  } catch (error) {
    console.log('Erro ao acessar o Google:', error.message);
  }

  // Mantém o navegador aberto por alguns segundos para visualização
  console.log('\nO navegador ficará aberto por 5 segundos...');
  await page.waitForTimeout(5000);

  // Fecha o navegador
  await browser.close();
  console.log('Navegador fechado.');
})();
