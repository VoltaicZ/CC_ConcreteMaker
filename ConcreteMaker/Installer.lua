fs.makeDir("CC_ConcreteMaker")

print("Downloading Files...")
shell.run("wget https://raw.githubusercontent.com/VoltaicZ/CC_ConcreteMaker/refs/heads/main/ConcreteMaker/ConcreteManager.lua CC_ConcreteMaker/ConcreteManager.lua")
print("Downloaded ConcreteManager.lua...")
shell.run("wget https://raw.githubusercontent.com/VoltaicZ/CC_ConcreteMaker/refs/heads/main/ConcreteMaker/ButtonManager.lua CC_ConcreteMaker/ButtonManager.lua")
print("Downloaded ButtonManager.lua...")