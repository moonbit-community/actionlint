import { spawn } from 'node:child_process';
import { constants } from 'node:os';

// Keep raw bytes until the caller chooses text or byte-exact comparisons.
export function run(command, args, cwd, input, env, timeout = 0) {
  return new Promise((resolve, reject) => {
    const child = spawn(command[0], [...command.slice(1), ...args], { cwd, env });
    const stdout = [];
    const stderr = [];
    let expired = false;
    const timer = timeout && setTimeout(() => {
      expired = true;
      child.kill('SIGKILL');
    }, timeout);
    child.stdout.on('data', chunk => stdout.push(chunk));
    child.stderr.on('data', chunk => stderr.push(chunk));
    child.on('error', reject);
    child.stdin.on('error', error => {
      if (error.code !== 'EPIPE' && error.code !== 'ECONNRESET') reject(error);
    });
    child.on('close', (code, signal) => {
      clearTimeout(timer);
      resolve(expired ? { timeout: true } : {
        code: code ?? -constants.signals[signal],
        stdout: Buffer.concat(stdout),
        stderr: Buffer.concat(stderr),
      });
    });
    child.stdin.end(input);
  });
}
