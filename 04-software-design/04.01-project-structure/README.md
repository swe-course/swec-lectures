## Mono-repo
* Prepare working directory
  ```
  cd ~/projects && mkdir mono-repo && cd mono-repo && git init && tln config --terse
  ```

## Multi-repo
* Prepare working directory
  ```
  cd ~/projects && mkdir multi-repo && cd multi-repo && tln config --terse
  ```
* Create two projects: one for frontend and one for backend
  ```
  mkdir frontend && cd frontend && git init && npx create-react-app . && tln config --terse --depend node-17.0.0 && tln install --depends
  ```
  ```
  git config --local user.name VladyslavKurmaz && git config --local user.email vladislav.kurmaz@gmail.com
  ```
  ```
  git add -A && git commit -m "v21.10.1" && git tag v21.10.1
  ```
  ```
  cd ..
  ```
  ```
  mkdir backend && cd backend && git init && npm init && tln config --terse --depend node-16.12.0 && tln install --depends
  ```
  ```
  git config --local user.name VladyslavKurmaz && git config --local user.email vladislav.kurmaz@gmail.com
  ```
  ```
  git add -A && git commit -m "v21.11.0" && git tag v21.11.0
  ```
  
* Create repository for whole solution
  ```
  cd ..
  ```
  ```
  mkdir saas && cd saas && git init && tln config --terse --depend kubectl-1.22.2 && tln install --depends
  ```
  ```
  git config --local user.name VladyslavKurmaz && git config --local user.email vladislav.kurmaz@gmail.com
  ```
  ```
  git add -A && git commit -m "init structure"
  ```
  
