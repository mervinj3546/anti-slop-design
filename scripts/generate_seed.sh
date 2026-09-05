#!/usr/bin/env bash
# Generates a long random alphanumeric string to use as design inspiration
# (String Seed of Thought technique — see SKILL.md Technique 1).
# Usage: ./generate_seed.sh [length]
LENGTH="${1:-64}"
head -c 256 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c "$LENGTH"
echo
