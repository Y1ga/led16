# 初始化粒子群  
num_particles = 20  
particles = []  
best_positions = []  
global_best_position = None  
global_best_fitness = float('inf')  
  
for _ in range(num_particles):  
    position = random.uniform(-10, 10)  # 初始化粒子位置  
    velocity = random.uniform(-1, 1)  # 初始化粒子速度  
    particles.append((position, velocity))  
    best_positions.append(position)  
  
# 迭代更新粒子群  
max_iterations = 100  
for iteration in range(max_iterations):  
    for i in range(num_particles):  
        position, velocity = particles[i]  
        fitness = evaluate_fitness(position)  # 计算适应度函数值  
  
        if fitness < evaluate_fitness(best_positions[i]):  
            best_positions[i] = position  # 更新个体最优解  
  
        if fitness < global_best_fitness:  
            global_best_fitness = fitness  # 更新群体最优解  
            global_best_position = position  
  
        # 更新粒子速度和位置  
        inertia_weight = 0.5  
        cognitive_weight = 1.0  
        social_weight = 1.0  
        inertia_term = inertia_weight * velocity  
        cognitive_term = cognitive_weight * random.uniform(0, 1) * (best_positions[i] - position)  
        social_term = social_weight * random.uniform(0, 1) * (global_best_position - position)  
        new_velocity = inertia_term + cognitive_term + social_term  
        new_position = position + new_velocity  
  
        particles[i] = (new_position, new_velocity)  