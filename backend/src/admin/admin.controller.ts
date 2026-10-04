import { Controller, Get } from '@nestjs/common';

import { AdminService } from './admin.service';

@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) { }

  @Get('categories/count')
  getCategoriesCount() {
    return this.adminService.getCategoriesCount();
  }

  @Get('ingredients/count')
  getIngredientsCount() {
    return this.adminService.getIngredientsCount();
  }

  @Get('employees/count')
  getEmployeesCount() {
    return this.adminService.getEmployeesCount();
  }
}
