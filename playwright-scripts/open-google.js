const { chromium } = require('playwright');
const path = require('path');

(async () => {
  console.log('Abrindo o navegador...');

  // Inicia o navegador em modo visível (não headless)
  const browser = await chromium.launch({
    headless: false,
    slowMo: 500 // Adiciona pequeno delay para visualização
  });

  // Cria uma nova página
  const page = await browser.newPage();

  // Primeiro tenta a página local para demonstrar que o Playwright funciona
  const localPath = path.join(__dirname, 'google-mock.html');
  console.log('Abrindo página de demonstração...');
  await page.goto(`file://${localPath}`);
  await page.waitForLoadState('load');
  console.log('Página de demonstração aberta!');
  console.log('Título da página:', await page.title());

  // Aguarda um momento para visualização
  await page.waitForTimeout(3000);

  // Tira um screenshot da página local
  const screenshotPath = path.join(__dirname, 'screenshot.png');
  try {
    await page.screenshot({ path: screenshotPath, fullPage: false, timeout: 10000 });
    console.log(`Screenshot salvo em: ${screenshotPath}`);
  } catch (e) {
    console.log('Screenshot não pôde ser salvo:', e.message);
  }

  // Tenta navegar para o Google real
  console.log('\nTentando navegar para https://google.com...');
  try {
    await page.goto('https://google.com', { timeout: 10000 });
    await page.waitForLoadState('networkidle');
    console.log('Google aberto com sucesso!');
    console.log('Título da página:', await page.title());
  } catch (error) {
    console.log('Não foi possível acessar o Google devido a restrições de rede.');
    console.log('(Este ambiente sandbox não tem acesso direto à internet)');
  }

  // Mantém o navegador aberto por alguns segundos para visualização
  console.log('\nO navegador ficará aberto por 5 segundos...');
  await page.waitForTimeout(5000);

  // Fecha o navegador
  await browser.close();
  console.log('Navegador fechado.');
})();
