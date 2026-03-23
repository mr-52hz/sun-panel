#!/bin/bash
cd "$(dirname "$0")"

echo "Starting backend..."
export CGO_ENABLED=1
export CC=/c/mingw64/bin/gcc.exe
cd service
go run main.go &
BACKEND_PID=$!

echo "Starting frontend..."
cd ..
pnpm exec vite &
FRONTEND_PID=$!

echo ""
echo "Backend: http://localhost:3002"
echo "Frontend: http://localhost:1002"
echo ""
echo "Press Ctrl+C to stop all services"

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit" INT TERM
wait
