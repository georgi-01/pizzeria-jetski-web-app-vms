import { Injectable } from '@nestjs/common';

import { CategoriesService } from '../categories/categories.service';
import { IngredientsService } from '../ingredients/ingredients.service';
import { EmployeesService } from '../employees/employees.service';

@Injectable()
export class AdminService {
  constructor(
    private readonly categoriesService: CategoriesService,
    private readonly ingredientsService: IngredientsService,
    private readonly employeesService: EmployeesService,
  ) {}

  async getCategoriesCount() {
    const count = await this.categoriesService.getCount();

    return {
      count,
    };
  }

  async getIngredientsCount() {
    const count = await this.ingredientsService.getCount();

    return {
      count,
    };
  }

  async getEmployeesCount() {
    const count = await this.employeesService.getCount();

    return {
      count,
    };
  }
}
