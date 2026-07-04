#!/usr/bin/env bash
# PreToolUse cost-guard — deep-research uyarısı.
# deep-research token-yoğun bir Workflow'dur (geçmişte ~1.8M token / ~13 dk / 100+ ajan).
# Bu hook, Workflow tool'u deep-research'ü çağırmadan ÖNCE araya girip kullanıcıdan
# açık onay ister ("ask"). Diğer workflow'lara dokunmaz (exit 0 = normal akış).
#
# Kurulum: .claude/settings.json → hooks.PreToolUse[matcher="Workflow"].
# Genel (tüm projeler) için: aynı bloğu ~/.claude/settings.json'a taşı.

set -euo pipefail
input="$(cat)"
name="$(printf '%s' "$input" | jq -r '.tool_input.name // empty' 2>/dev/null || true)"

if [ "$name" = "deep-research" ]; then
  # permissionDecision "ask" → Claude Code interaktif onay istemi + bu gerekçeyi gösterir.
  cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"⚠ deep-research PAHALIDIR — geçmişte ~1.8M token · ~13 dk · 100+ ajan. Onaylarsan çalışır. Alternatif: tek bir özet-ajan (Agent) ya da hedefli WebSearch çok daha ucuz. Devam edilsin mi?"}}
JSON
  exit 0
fi

# deep-research değil → sessizce izin ver.
exit 0
